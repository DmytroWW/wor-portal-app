
CREATE TABLE gvg_battle_defense_heroes (
    id BIGSERIAL PRIMARY KEY,
    slot_id BIGINT NOT NULL REFERENCES gvg_battle_slots(id) ON DELETE CASCADE,
    hero_id BIGINT NOT NULL,
    tile_id BIGINT NOT NULL REFERENCES gvg_map_tiles(id),
    attack_direction VARCHAR(12) NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_gvg_battle_defense_hero UNIQUE (slot_id, hero_id),
    CONSTRAINT uk_gvg_battle_defense_tile UNIQUE (slot_id, tile_id),
    CONSTRAINT chk_gvg_battle_defense_direction CHECK (attack_direction IN ('UP', 'RIGHT', 'DOWN', 'LEFT'))
);
CREATE INDEX idx_gvg_battle_defense_slot ON gvg_battle_defense_heroes(slot_id);
