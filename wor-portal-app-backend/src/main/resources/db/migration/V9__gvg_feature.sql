
-- ============================================================
-- GVG ENUM TYPES
-- ============================================================

CREATE TYPE gvg_map_type AS ENUM (
    'FORT',
    'TOWER'
);

CREATE TYPE gvg_tile_type AS ENUM (
    'GROUND',
    'PLATFORM'
);

CREATE TYPE attack_direction AS ENUM (
    'UP',
    'DOWN',
    'LEFT',
    'RIGHT'
);


-- ============================================================
-- GVG MAPS
-- ============================================================

CREATE TABLE gvg_maps (
    id BIGSERIAL PRIMARY KEY,

    -- Logical GVG rotation number.
    -- Each rotation contains exactly one FORT and one TOWER map.
    season_number INTEGER NOT NULL,

    map_type gvg_map_type NOT NULL,

    name VARCHAR(100) NOT NULL,

    width INTEGER NOT NULL,

    height INTEGER NOT NULL,

    is_active BOOLEAN NOT NULL DEFAULT FALSE,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_gvg_map_season_number
        CHECK (season_number > 0),

    CONSTRAINT chk_gvg_map_width
        CHECK (width > 0),

    CONSTRAINT chk_gvg_map_height
        CHECK (height > 0),

    -- One FORT and one TOWER per rotation.
    CONSTRAINT uk_gvg_map_season_type
        UNIQUE (season_number, map_type)
);


-- Only one active map per map type.
-- This allows exactly one active FORT and one active TOWER.
CREATE UNIQUE INDEX ux_gvg_map_one_active_per_type
    ON gvg_maps (map_type)
    WHERE is_active = TRUE;


-- ============================================================
-- GVG MAP TILES
-- ============================================================

CREATE TABLE gvg_map_tiles (
    id BIGSERIAL PRIMARY KEY,

    map_id BIGINT NOT NULL,

    x INTEGER NOT NULL,

    y INTEGER NOT NULL,

    tile_type gvg_tile_type NOT NULL,

    -- Direction characteristic of this map tile.
    -- NULL means that the tile has no predefined direction.
    attack_direction attack_direction,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_gvg_map_tile_map
        FOREIGN KEY (map_id)
        REFERENCES gvg_maps(id)
        ON DELETE CASCADE,

    CONSTRAINT chk_gvg_map_tile_x
        CHECK (x >= 0),

    CONSTRAINT chk_gvg_map_tile_y
        CHECK (y >= 0),

    -- A map cannot have two tiles at the same coordinates.
    CONSTRAINT uk_gvg_map_tile_position
        UNIQUE (map_id, x, y)
);


CREATE INDEX idx_gvg_map_tiles_map_id
    ON gvg_map_tiles (map_id);


-- ============================================================
-- GVG PRESETS
-- ============================================================

CREATE TABLE gvg_presets (
    id BIGSERIAL PRIMARY KEY,

    -- Guild that owns this preset.
    guild_id BIGINT NOT NULL,

    -- Exact map for which this preset was created.
    -- The preset remains bound to this map even when
    -- a newer rotation/map becomes active.
    map_id BIGINT NOT NULL,

    -- Short attack/preset identifier.
    -- Unique only inside the guild.
    preset_code VARCHAR(100) NOT NULL,

    -- Human-readable preset name.
    name VARCHAR(150),

    -- User's note/description for this attack.
    description TEXT,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_gvg_preset_guild
        FOREIGN KEY (guild_id)
        REFERENCES guilds(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_gvg_preset_map
        FOREIGN KEY (map_id)
        REFERENCES gvg_maps(id)
        ON DELETE RESTRICT,

    -- The same preset code cannot be used twice
    -- inside the same guild.
    CONSTRAINT uk_gvg_preset_guild_code
        UNIQUE (guild_id, preset_code)
);


CREATE INDEX idx_gvg_presets_guild_id
    ON gvg_presets (guild_id);

CREATE INDEX idx_gvg_presets_map_id
    ON gvg_presets (map_id);

CREATE INDEX idx_gvg_presets_guild_map
    ON gvg_presets (guild_id, map_id);


-- ============================================================
-- GVG PRESET HEROES
-- ============================================================

CREATE TABLE gvg_preset_heroes (
    id BIGSERIAL PRIMARY KEY,

    preset_id BIGINT NOT NULL,

    hero_id BIGINT NOT NULL,

    -- Tile where the hero is placed.
    -- NULL is allowed for an unfinished/draft preset.
    tile_id BIGINT,

    -- Exact direction selected for this hero in this preset.
    -- Every placed hero has exactly one direction.
    attack_direction attack_direction NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_gvg_preset_hero_preset
        FOREIGN KEY (preset_id)
        REFERENCES gvg_presets(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_gvg_preset_hero_hero
        FOREIGN KEY (hero_id)
        REFERENCES heroes(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_gvg_preset_hero_tile
        FOREIGN KEY (tile_id)
        REFERENCES gvg_map_tiles(id)
        ON DELETE RESTRICT,

    -- The same hero can only appear once in one preset.
    CONSTRAINT uk_gvg_preset_hero
        UNIQUE (preset_id, hero_id),

    -- One tile can contain at most one hero in one preset.
    -- PostgreSQL allows multiple NULL values in a UNIQUE constraint,
    -- so multiple unfinished heroes without a tile are still allowed.
    CONSTRAINT uk_gvg_preset_hero_tile
        UNIQUE (preset_id, tile_id)
);


CREATE INDEX idx_gvg_preset_heroes_preset_id
    ON gvg_preset_heroes (preset_id);

CREATE INDEX idx_gvg_preset_heroes_hero_id
    ON gvg_preset_heroes (hero_id);

CREATE INDEX idx_gvg_preset_heroes_tile_id
    ON gvg_preset_heroes (tile_id);


-- ============================================================
-- GVG PRESET SOLDIERS
-- ============================================================

CREATE TABLE gvg_preset_soldiers (
    id BIGSERIAL PRIMARY KEY,

    preset_id BIGINT NOT NULL,

    soldier_id BIGINT NOT NULL,

    -- Soldier level selected specifically for this preset.
    -- This does NOT modify demon_soldiers.level.
    level INTEGER NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_gvg_preset_soldier_preset
        FOREIGN KEY (preset_id)
        REFERENCES gvg_presets(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_gvg_preset_soldier_soldier
        FOREIGN KEY (soldier_id)
        REFERENCES demon_soldiers(id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_gvg_preset_soldier_level
        CHECK (level BETWEEN 1 AND 10),

    -- The same soldier cannot be listed twice in one preset.
    CONSTRAINT uk_gvg_preset_soldier
        UNIQUE (preset_id, soldier_id)
);


CREATE INDEX idx_gvg_preset_soldiers_preset_id
    ON gvg_preset_soldiers (preset_id);

CREATE INDEX idx_gvg_preset_soldiers_soldier_id
    ON gvg_preset_soldiers (soldier_id);
