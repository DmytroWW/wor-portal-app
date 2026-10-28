-- PostgreSQL migration SQL for the GvG War Room feature.

CREATE TABLE gvg_battle_rounds (
    id BIGSERIAL PRIMARY KEY,
    guild_id BIGINT NOT NULL,
    round_number INTEGER NOT NULL,
    opponent_name VARCHAR(150) NOT NULL,
    status VARCHAR(16) NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    locked_at TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT uk_gvg_battle_round_guild_number UNIQUE (guild_id, round_number),
    CONSTRAINT chk_gvg_battle_round_number CHECK (round_number > 0),
    CONSTRAINT chk_gvg_battle_round_status CHECK (status IN ('ACTIVE', 'LOCKED'))
);

-- Guard against two active rounds belonging to one guild, including concurrent requests.
CREATE UNIQUE INDEX uq_gvg_battle_one_active_round_per_guild
    ON gvg_battle_rounds(guild_id)
    WHERE status = 'ACTIVE';

CREATE TABLE gvg_battle_slots (
    id BIGSERIAL PRIMARY KEY,
    round_id BIGINT NOT NULL REFERENCES gvg_battle_rounds(id) ON DELETE CASCADE,
    map_type VARCHAR(12) NOT NULL,
    slot_number INTEGER NOT NULL,
    lane_number INTEGER NOT NULL,
    defense_preset_id BIGINT REFERENCES gvg_presets(id) ON DELETE SET NULL,
    opponent_nickname VARCHAR(100),
    battle_power BIGINT,
    mirror_note TEXT,
    breached BOOLEAN NOT NULL DEFAULT FALSE,
    breached_by_1 VARCHAR(100),
    breached_by_2 VARCHAR(100),
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_gvg_battle_slot_position UNIQUE (round_id, map_type, slot_number, lane_number),
    CONSTRAINT chk_gvg_battle_slot_map_type CHECK (map_type IN ('FORT', 'TOWER')),
    CONSTRAINT chk_gvg_battle_slot_number CHECK (
        (map_type = 'TOWER' AND slot_number BETWEEN 1 AND 25)
        OR (map_type = 'FORT' AND slot_number BETWEEN 1 AND 5)
    ),
    CONSTRAINT chk_gvg_battle_slot_lane CHECK (lane_number IN (1, 2)),
    CONSTRAINT chk_gvg_battle_slot_battle_power CHECK (battle_power IS NULL OR battle_power >= 0)
);

CREATE INDEX idx_gvg_battle_slots_round_type
    ON gvg_battle_slots(round_id, map_type);
