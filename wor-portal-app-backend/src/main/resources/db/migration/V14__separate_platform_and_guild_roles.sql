-- Separates global application permissions from a user's rank inside one guild.
-- Keeps the existing users.guild_id relationship and the legacy `role` column
-- for a transition period so older application code/data can be rolled back.

ALTER TABLE users
    ADD COLUMN platform_role VARCHAR(20),
    ADD COLUMN guild_role VARCHAR(20);

-- Global role: only the existing ADMIN account(s) remain platform admins.
UPDATE users
SET platform_role = CASE
    WHEN UPPER(COALESCE(role, '')) = 'ADMIN' THEN 'ADMIN'
    ELSE 'USER'
END;

-- Move old guild ranks to the new guild_role column.
UPDATE users
SET guild_role = CASE
    WHEN guild_id IS NULL THEN NULL
    WHEN UPPER(COALESCE(role, '')) = 'LEADER' THEN 'LEADER'
    WHEN UPPER(COALESCE(role, '')) = 'OFFICER' THEN 'OFFICER'
    ELSE 'MEMBER'
END;

-- Guarantee exactly one leader per guild that has members:
-- keep the lowest-ID existing leader; if there is no leader, promote the
-- lowest-ID member. Any additional existing leaders become officers.
WITH ranked_members AS (
    SELECT
        id,
        guild_id,
        guild_role,
        ROW_NUMBER() OVER (
            PARTITION BY guild_id
            ORDER BY CASE WHEN guild_role = 'LEADER' THEN 0 ELSE 1 END, id ASC
        ) AS member_rank
    FROM users
    WHERE guild_id IS NOT NULL
)
UPDATE users AS u
SET guild_role = CASE
    WHEN ranked_members.member_rank = 1 THEN 'LEADER'
    WHEN ranked_members.guild_role = 'LEADER' THEN 'OFFICER'
    ELSE COALESCE(ranked_members.guild_role, 'MEMBER')
END
FROM ranked_members
WHERE u.id = ranked_members.id;

-- Normalize old `role` data so legacy enum mappings remain readable during
-- the transition. New code must use platform_role and guild_role instead.
UPDATE users
SET role = CASE WHEN platform_role = 'ADMIN' THEN 'ADMIN' ELSE 'MEMBER' END;

ALTER TABLE users
    ALTER COLUMN platform_role SET DEFAULT 'USER',
    ALTER COLUMN platform_role SET NOT NULL;

ALTER TABLE users
    ADD CONSTRAINT chk_users_platform_role
        CHECK (platform_role IN ('USER', 'ADMIN')),
    ADD CONSTRAINT chk_users_guild_role
        CHECK (guild_role IS NULL OR guild_role IN ('LEADER', 'OFFICER', 'MEMBER')),
    ADD CONSTRAINT chk_users_guild_role_membership
        CHECK (
            (guild_id IS NULL AND guild_role IS NULL)
            OR (guild_id IS NOT NULL AND guild_role IS NOT NULL)
        );

-- The database guarantees at most one guild leader. The service demotes the
-- current leader and flushes before promoting the next leader.
CREATE UNIQUE INDEX uk_users_one_leader_per_guild
    ON users (guild_id)
    WHERE guild_id IS NOT NULL AND guild_role = 'LEADER';
