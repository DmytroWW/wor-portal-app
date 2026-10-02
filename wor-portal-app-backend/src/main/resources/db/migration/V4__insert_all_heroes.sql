-- Автоматично згенерована міграція для всіх героїв
                -- 1. Головна таблиця героїв
                CREATE TABLE IF NOT EXISTS heroes (
                    id BIGSERIAL PRIMARY KEY,
                    name VARCHAR(50) NOT NULL UNIQUE,
                    image_slug VARCHAR(255) NOT NULL,
                    class_name VARCHAR(255) NOT NULL,
                    class_icon_slug VARCHAR(255),
                    rarity VARCHAR(50),
                    lord_faction VARCHAR(255)
                );

                -- 2. Таблиця для списку фракцій героя (@ElementCollection)
                CREATE TABLE IF NOT EXISTS hero_faction_list (
                    hero_id BIGINT NOT NULL,
                    faction_name VARCHAR(255),
                    CONSTRAINT fk_hero_faction FOREIGN KEY (hero_id) REFERENCES heroes(id) ON DELETE CASCADE
                );

                -- 3. Таблиця для тегів героя (@ElementCollection)
                CREATE TABLE IF NOT EXISTS hero_tags (
                    hero_id BIGINT NOT NULL,
                    tag VARCHAR(255),
                    CONSTRAINT fk_hero_tag FOREIGN KEY (hero_id) REFERENCES heroes(id) ON DELETE CASCADE
                );

                -- 4. Таблиця зв'язку користувачів і героїв (ростер)
                CREATE TABLE IF NOT EXISTS user_heroes (
                    id BIGSERIAL PRIMARY KEY,
                    user_id BIGINT NOT NULL,
                    hero_id BIGINT NOT NULL,
                    awakening_level INT NOT NULL DEFAULT 0,
                    CONSTRAINT fk_user_hero_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
                    CONSTRAINT fk_user_hero_hero FOREIGN KEY (hero_id) REFERENCES heroes(id) ON DELETE CASCADE,
                    CONSTRAINT uk_user_hero UNIQUE (user_id, hero_id)
                );

                -- Герой: Abyzou
                INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Abyzou', 'abyzou', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
                INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult Lord' FROM heroes WHERE name = 'Abyzou' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult Lord');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Abyzou' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Abyzou' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

                -- Герой: Aeon
                INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Aeon', 'aeon', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
                INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult Lord' FROM heroes WHERE name = 'Aeon' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult Lord');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Aeon' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Aeon' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Aeon' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

                -- Герой: Ain
                INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Ain', 'ain', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
                INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard Lord' FROM heroes WHERE name = 'Ain' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard Lord');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Ain' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Ain' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Ain' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Ain' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');

                -- Герой: Amelia Ainsworth
                INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Amelia Ainsworth', 'amelia_ainsworth', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
                INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Grey Blades Lord' FROM heroes WHERE name = 'Amelia Ainsworth' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Grey Blades Lord');

                -- Герой: Aracha
                INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Aracha', 'aracha', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
                INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers Lord' FROM heroes WHERE name = 'Aracha' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers Lord');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Aracha' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Aracha' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Aracha' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Aracha' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

                -- Герой: Borut
                INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Borut', 'borut', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
                INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard Lord' FROM heroes WHERE name = 'Borut' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard Lord');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Borut' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');

                -- Герой: Cyrus
                INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Cyrus', 'cyrus', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
                INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order Lord' FROM heroes WHERE name = 'Cyrus' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order Lord');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Cyrus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Summon' FROM heroes WHERE name = 'Cyrus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Summon');

                -- Герой: Dagna
                INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Dagna', 'dagna', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
                INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne Lord' FROM heroes WHERE name = 'Dagna' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne Lord');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Dagna' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');

                -- Герой: Demi
                INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Demi', 'demi', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
                INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult Lord' FROM heroes WHERE name = 'Demi' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult Lord');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Demi' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Healing' FROM heroes WHERE name = 'Demi' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Healing');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Invisibility' FROM heroes WHERE name = 'Demi' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Invisibility');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Demi' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

                -- Герой: Elddr
                INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Elddr', 'elddr', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
                INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne Lord' FROM heroes WHERE name = 'Elddr' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne Lord');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Elddr' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Elddr' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Elddr' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');

                -- Герой: Eliza
                INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Eliza', 'eliza', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
                INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers Lord' FROM heroes WHERE name = 'Eliza' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers Lord');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Eliza' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Invisibility' FROM heroes WHERE name = 'Eliza' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Invisibility');
                INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Eliza' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

                -- Герой: Elysia
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Elysia', 'elysia', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Supreme Arbiter Lord' FROM heroes WHERE name = 'Elysia' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Supreme Arbiter Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Elysia' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'True DMG' FROM heroes WHERE name = 'Elysia' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'True DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Elysia' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Elysia' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Ezareth
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Ezareth', 'ezareth', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult Lord' FROM heroes WHERE name = 'Ezareth' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Ezareth' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Ezareth' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Ezareth' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');

-- Герой: Galloway
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Galloway', 'galloway', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Grey Blades Lord' FROM heroes WHERE name = 'Galloway' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Grey Blades Lord');

-- Герой: Ghan
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Ghan', 'ghan', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion Lord' FROM heroes WHERE name = 'Ghan' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Ghan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'High Block' FROM heroes WHERE name = 'Ghan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'High Block');

-- Герой: Ingrid
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Ingrid', 'ingrid', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard Lord' FROM heroes WHERE name = 'Ingrid' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Ingrid' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Ingrid' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Ingrid' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Ingrid' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Ingrid' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Iovar
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Iovar', 'iovar', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers Lord' FROM heroes WHERE name = 'Iovar' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Iovar' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Iovar' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Iovar' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Isolde
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Isolde', 'isolde', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne Lord' FROM heroes WHERE name = 'Isolde' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'High Block' FROM heroes WHERE name = 'Isolde' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'High Block');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Isolde' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');

-- Герой: Jezebelle
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Jezebelle', 'jezebelle', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion Lord' FROM heroes WHERE name = 'Jezebelle' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Jezebelle' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Jezebelle' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'DEF Penetration' FROM heroes WHERE name = 'Jezebelle' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'DEF Penetration');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Jezebelle' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: King Harz
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('King Harz', 'king_harz', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne Lord' FROM heroes WHERE name = 'King Harz' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'King Harz' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'King Harz' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'King Harz' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');

-- Герой: Laya
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Laya', 'laya', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard Lord' FROM heroes WHERE name = 'Laya' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE Heal' FROM heroes WHERE name = 'Laya' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Rage Regen' FROM heroes WHERE name = 'Laya' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Rage Regen');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Laya' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Luneria
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Luneria', 'luneria', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers Lord' FROM heroes WHERE name = 'Luneria' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Luneria' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Luneria' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Luneria' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Morrigan
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Morrigan', 'morrigan', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult Lord' FROM heroes WHERE name = 'Morrigan' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Morrigan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Morrigan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Morrigan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Nastya
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Nastya', 'nastya', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order Lord' FROM heroes WHERE name = 'Nastya' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Nastya' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Nastya' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Nastya' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Nastya' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Oren
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Oren', 'oren', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Supreme Arbiter Lord' FROM heroes WHERE name = 'Oren' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Supreme Arbiter Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Oren' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Oren' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Oren' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Oren' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'True DMG' FROM heroes WHERE name = 'Oren' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'True DMG');

-- Герой: Praetus
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Praetus', 'praetus', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Supreme Arbiter Lord' FROM heroes WHERE name = 'Praetus' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Supreme Arbiter Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Praetus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Praetus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'True DMG' FROM heroes WHERE name = 'Praetus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'True DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Praetus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Praetus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Pyros
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Pyros', 'pyros', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast Lord' FROM heroes WHERE name = 'Pyros' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Pyros' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Pyros' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Pyros' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Raiden
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Raiden', 'raiden', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order Lord' FROM heroes WHERE name = 'Raiden' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Raiden' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Raiden' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Rivenhald
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Rivenhald', 'rivenhald', 'Tactician', 'tactician') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne Lord' FROM heroes WHERE name = 'Rivenhald' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Rivenhald' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE Heal' FROM heroes WHERE name = 'Rivenhald' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Rivenhald' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Rivenhald' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');

-- Герой: Rork
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Rork', 'rork', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne Lord' FROM heroes WHERE name = 'Rork' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Rork' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Rork' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');

-- Герой: Rygar
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Rygar', 'rygar', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council Lord' FROM heroes WHERE name = 'Rygar' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Rygar' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Rygar' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Rygar' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');

-- Герой: Solcadens
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Solcadens', 'solcadens', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast Lord' FROM heroes WHERE name = 'Solcadens' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Solcadens' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Solcadens' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Solcadens' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');

-- Герой: Torodor
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Torodor', 'torodor', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council Lord' FROM heroes WHERE name = 'Torodor' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Torodor' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Torodor' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Torodor' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Twinfiend
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Twinfiend', 'twinfiend', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast Lord' FROM heroes WHERE name = 'Twinfiend' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Twinfiend' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Twinfiend' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Twinfiend' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Twinfiend' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Valderon
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Valderon', 'valderon', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion Lord' FROM heroes WHERE name = 'Valderon' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Valderon' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Valderon' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Valderon' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Venoma
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Venoma', 'venoma', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order Lord' FROM heroes WHERE name = 'Venoma' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Venoma' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Venoma' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Venoma' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Veyrathia
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Veyrathia', 'veyrathia', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council Lord' FROM heroes WHERE name = 'Veyrathia' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Veyrathia' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');

-- Герой: Vixera
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Vixera', 'vixera', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order Lord' FROM heroes WHERE name = 'Vixera' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Vixera' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Vixera' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Vixera' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Vixera' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Vladov
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Vladov', 'vladov', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion Lord' FROM heroes WHERE name = 'Vladov' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Vladov' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Vladov' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');

-- Герой: Wrath
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Wrath', 'wrath', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council Lord' FROM heroes WHERE name = 'Wrath' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council Lord');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Wrath' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');

-- Герой: Abomination
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Abomination', 'abomination', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Abomination' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Abomination' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Abomination' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');

-- Герой: Admiral Claw
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Admiral Claw', 'admiral_claw', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Admiral Claw' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Admiral Claw' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Admiral Claw' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');

-- Герой: Aedrin
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Aedrin', 'aedrin', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Aedrin' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Aedrin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Aedrin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Aedrin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'DEF Penetration' FROM heroes WHERE name = 'Aedrin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'DEF Penetration');

-- Герой: Aeris
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Aeris', 'aeris', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Aeris' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Aeris' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Aeris' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Aeris' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Ai
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Ai', 'ai', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Ai' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Ai' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Ai' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');

-- Герой: Ajax
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Ajax', 'ajax', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Unnamable' FROM heroes WHERE name = 'Ajax' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Unnamable');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Ajax' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Ajax' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Ajax' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Akira
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Akira', 'akira', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Akira' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Akira' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Akira' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Akira' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Alaura
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Alaura', 'alaura', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Alaura' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Alaura' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Invisibility' FROM heroes WHERE name = 'Alaura' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Invisibility');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Alaura' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Alistair
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Alistair', 'alistair', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Supreme Arbiter' FROM heroes WHERE name = 'Alistair' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Supreme Arbiter');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Alistair' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'True DMG' FROM heroes WHERE name = 'Alistair' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'True DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Alistair' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Alistair' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');

-- Герой: Amahle
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Amahle', 'amahle', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Amahle' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Amahle' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');

-- Герой: Anai
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Anai', 'anai', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Anai' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Anai' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Anai' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Anai' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Anora
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Anora', 'anora', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Anora' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Anora' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Anora' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Summon' FROM heroes WHERE name = 'Anora' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Summon');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Anora' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Apsan
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Apsan', 'apsan', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Apsan' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Apsan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Apsan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Ardea
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Ardea', 'ardea', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Ardea' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Ardea' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Ardea' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Ardea' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');

-- Герой: Ardeth
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Ardeth', 'ardeth', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Ardeth' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Ardeth' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Ardeth' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Ares
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Ares', 'ares', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Ares' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Ares' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Ares' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Arlow
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Arlow', 'arlow', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Arlow' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Cost Regen' FROM heroes WHERE name = 'Arlow' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Cost Regen');

-- Герой: Arrogance
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Arrogance', 'arrogance', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Arrogance' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Arrogance' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Arrogance' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Arrogance' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Artemis
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Artemis', 'artemis', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Artemis' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE Heal' FROM heroes WHERE name = 'Artemis' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Healing' FROM heroes WHERE name = 'Artemis' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Healing');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Artemis' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Aryn
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Aryn', 'aryn', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Aryn' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE Heal' FROM heroes WHERE name = 'Aryn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Defensive Dispel' FROM heroes WHERE name = 'Aryn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Defensive Dispel');

-- Герой: Astrael
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Astrael', 'astrael', 'Tactician', 'tactician') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Astrael' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Astrael' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Displacement' FROM heroes WHERE name = 'Astrael' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Displacement');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Astrael' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Astrael' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Atrox
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Atrox', 'atrox', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Atrox' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Atrox' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Fast Revival' FROM heroes WHERE name = 'Atrox' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Fast Revival');

-- Герой: Aurelius Gale
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Aurelius Gale', 'aurelius_gale', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Aurelius Gale' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Aurelius Gale' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Healing' FROM heroes WHERE name = 'Aurelius Gale' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Healing');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Aurelius Gale' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Aurelius Gale' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Autumn
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Autumn', 'autumn', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Autumn' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE Heal' FROM heroes WHERE name = 'Autumn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Autumn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Aveline
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Aveline', 'aveline', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Aveline' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'High Block' FROM heroes WHERE name = 'Aveline' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'High Block');

-- Герой: Aylin
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Aylin', 'aylin', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Aylin' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE Heal' FROM heroes WHERE name = 'Aylin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Aylin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');

-- Герой: Azhor
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Azhor', 'azhor', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Azhor' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Azhor' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Azhor' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Azhor' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');

-- Герой: Azzoth
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Azzoth', 'azzoth', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Azzoth' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Azzoth' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Azzoth' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Azzoth' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Barclay
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Barclay', 'barclay', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Barclay' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Barclay' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Barclay' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Baron
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Baron', 'baron', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Baron' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Baron' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');

-- Герой: Bayek
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Bayek', 'bayek', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Bayek' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Bayek' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Bayek' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Bayek' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Beatrix
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Beatrix', 'beatrix', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Beatrix' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Beatrix' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Summon' FROM heroes WHERE name = 'Beatrix' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Summon');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Beatrix' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Beelzebub
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Beelzebub', 'beelzebub', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Beelzebub' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Beelzebub' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Summon' FROM heroes WHERE name = 'Beelzebub' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Summon');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Beelzebub' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Boreas
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Boreas', 'boreas', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Boreas' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Boreas' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Boreas' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Healing' FROM heroes WHERE name = 'Boreas' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Healing');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Boreas' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Brienne
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Brienne', 'brienne', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Brienne' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Brienne' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Brienne' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Brokkir
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Brokkir', 'brokkir', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Brokkir' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Brokkir' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Brokkir' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Brokkir' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');

-- Герой: Brunor
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Brunor', 'brunor', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Brunor' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Brunor' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Brunor' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Brunor' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Cainan
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Cainan', 'cainan', 'Tactician', 'tactician') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Cainan' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Cainan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'True DMG' FROM heroes WHERE name = 'Cainan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'True DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Dual-Target ATK' FROM heroes WHERE name = 'Cainan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Dual-Target ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Displacement' FROM heroes WHERE name = 'Cainan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Displacement');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Cainan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Calista
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Calista', 'calista', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Calista' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Calista' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');

-- Герой: Calypso
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Calypso', 'calypso', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Calypso' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Calypso' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Calypso' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Calypso' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Camille
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Camille', 'camille', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Camille' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target Heal' FROM heroes WHERE name = 'Camille' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target Heal');

-- Герой: Captain Reve
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Captain Reve', 'captain_reve', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Captain Reve' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Captain Reve' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Captain Reve' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');

-- Герой: Carnelian
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Carnelian', 'carnelian', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Carnelian' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Carnelian' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE Heal' FROM heroes WHERE name = 'Carnelian' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE Heal');

-- Герой: Carosa
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Carosa', 'carosa', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Carosa' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Carosa' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Carosa' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Cassiel
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Cassiel', 'cassiel', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Supreme Arbiter' FROM heroes WHERE name = 'Cassiel' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Supreme Arbiter');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Cassiel' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Cassiel' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Cassiel' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');

-- Герой: Cerberus
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Cerberus', 'cerberus', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Cerberus' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Cerberus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');

-- Герой: Clarissa
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Clarissa', 'clarissa', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Clarissa' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Clarissa' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Clarissa' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Healing' FROM heroes WHERE name = 'Clarissa' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Healing');

-- Герой: Constance
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Constance', 'constance', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Constance' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target Heal' FROM heroes WHERE name = 'Constance' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Constance' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Corven
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Corven', 'corven', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Corven' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Corven' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Corven' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Corven' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Summon' FROM heroes WHERE name = 'Corven' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Summon');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Corven' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Count Dracula
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Count Dracula', 'count_dracula', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Count Dracula' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Count Dracula' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Count Dracula' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Healing' FROM heroes WHERE name = 'Count Dracula' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Healing');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Count Dracula' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Count Dracula' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Crach
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Crach', 'crach', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Crach' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Crach' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Crach' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Cuke
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Cuke', 'cuke', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Cuke' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Cuke' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Cuke' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Cuke' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Cutter
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Cutter', 'cutter', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Cutter' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Cutter' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Cutter' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Cutter' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Cyclone
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Cyclone', 'cyclone', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Cyclone' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Cyclone' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');

-- Герой: Cyrene
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Cyrene', 'cyrene', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Cyrene' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Cost Regen' FROM heroes WHERE name = 'Cyrene' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Cost Regen');

-- Герой: Daemon
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Daemon', 'daemon', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Daemon' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Fast Revival' FROM heroes WHERE name = 'Daemon' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Fast Revival');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Daemon' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');

-- Герой: Dahlia
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Dahlia', 'dahlia', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Dahlia' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Dahlia' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Dahlia' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Dahlia' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'High Block' FROM heroes WHERE name = 'Dahlia' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'High Block');

-- Герой: Dalyn
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Dalyn', 'dalyn', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Dalyn' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Cost Regen' FROM heroes WHERE name = 'Dalyn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Cost Regen');

-- Герой: Dane
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Dane', 'dane', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Dane' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Dane' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Dane' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Dane' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Healing' FROM heroes WHERE name = 'Dane' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Healing');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Dane' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Dassomi
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Dassomi', 'dassomi', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Dassomi' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE Heal' FROM heroes WHERE name = 'Dassomi' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Defensive Dispel' FROM heroes WHERE name = 'Dassomi' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Defensive Dispel');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Dassomi' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Decimus
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Decimus', 'decimus', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Decimus' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Decimus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Decimus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');

-- Герой: Deimos
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Deimos', 'deimos', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Deimos' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Deimos' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Deimos' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');

-- Герой: Diaochan
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Diaochan', 'diaochan', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Diaochan' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Diaochan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE Heal' FROM heroes WHERE name = 'Diaochan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Diaochan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');

-- Герой: Dolores
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Dolores', 'dolores', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Dolores' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE Heal' FROM heroes WHERE name = 'Dolores' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Dolores' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Dr. Van Helsing
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Dr. Van Helsing', 'dr._van_helsing', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Dr. Van Helsing' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Dr. Van Helsing' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Dr. Van Helsing' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Dr. Van Helsing' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Draelyn
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Draelyn', 'draelyn', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Draelyn' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target Heal' FROM heroes WHERE name = 'Draelyn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Draelyn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Drayga
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Drayga', 'drayga', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Drayga' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Drayga' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');

-- Герой: Duradel
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Duradel', 'duradel', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Duradel' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Duradel' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');

-- Герой: Durza
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Durza', 'durza', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Durza' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Durza' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Durza' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Durza' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Edith
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Edith', 'edith', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Edith' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Edith' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Edith' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Edith' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');

-- Герой: Eirlys
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Eirlys', 'eirlys', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Eirlys' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target Heal' FROM heroes WHERE name = 'Eirlys' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Eirlys' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Eirlys' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Rage Regen' FROM heroes WHERE name = 'Eirlys' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Rage Regen');

-- Герой: Eivor Varinsdottir
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Eivor Varinsdottir', 'eivor_varinsdottir', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Eivor Varinsdottir' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Eivor Varinsdottir' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'DEF Penetration' FROM heroes WHERE name = 'Eivor Varinsdottir' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'DEF Penetration');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Offensive Dispel' FROM heroes WHERE name = 'Eivor Varinsdottir' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Offensive Dispel');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Eivor Varinsdottir' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');

-- Герой: Elowyn
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Elowyn', 'elowyn', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Elowyn' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE Heal' FROM heroes WHERE name = 'Elowyn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Defensive Dispel' FROM heroes WHERE name = 'Elowyn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Defensive Dispel');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Rage Regen' FROM heroes WHERE name = 'Elowyn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Rage Regen');

-- Герой: Elukas
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Elukas', 'elukas', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Elukas' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Elukas' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Elukas' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Eona
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Eona', 'eona', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Eona' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Eona' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Eona' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Erlang Shen
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Erlang Shen', 'erlang_shen', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Supreme Arbiter' FROM heroes WHERE name = 'Erlang Shen' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Supreme Arbiter');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Erlang Shen' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Erlang Shen' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Erlang Shen' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Erlang Shen' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Esme
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Esme', 'esme', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Esme' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Esme' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Esme' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Esme' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Estrid
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Estrid', 'estrid', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Estrid' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Estrid' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Estrid' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Eunomia
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Eunomia', 'eunomia', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Supreme Arbiter' FROM heroes WHERE name = 'Eunomia' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Supreme Arbiter');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE Heal' FROM heroes WHERE name = 'Eunomia' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Eunomia' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Defensive Dispel' FROM heroes WHERE name = 'Eunomia' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Defensive Dispel');

-- Герой: Evie Frye
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Evie Frye', 'evie_frye', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Evie Frye' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Evie Frye' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Evie Frye' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Evie Frye' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Ezio Auditore
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Ezio Auditore', 'ezio_auditore', 'Tactician', 'tactician') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Supreme Arbiter' FROM heroes WHERE name = 'Ezio Auditore' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Supreme Arbiter');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Ezio Auditore' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Displacement' FROM heroes WHERE name = 'Ezio Auditore' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Displacement');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'DEF Penetration' FROM heroes WHERE name = 'Ezio Auditore' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'DEF Penetration');

-- Герой: Ezio Della Notte
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Ezio Della Notte', 'ezio_della_notte', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Ezio Della Notte' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Ezio Della Notte' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Summon' FROM heroes WHERE name = 'Ezio Della Notte' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Summon');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Ezio Della Notte' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Ezryn
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Ezryn', 'ezryn', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Ezryn' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target Heal' FROM heroes WHERE name = 'Ezryn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Ezryn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');

-- Герой: Faelin
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Faelin', 'faelin', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Faelin' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Faelin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Faelin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Faelin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Faelin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Falcia
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Falcia', 'falcia', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Falcia' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Falcia' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Falcia' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'True DMG' FROM heroes WHERE name = 'Falcia' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'True DMG');

-- Герой: Fenris
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Fenris', 'fenris', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Fenris' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Fenris' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Fenris' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Rage Regen' FROM heroes WHERE name = 'Fenris' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Rage Regen');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Fenris' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Ferssi
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Ferssi', 'ferssi', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Ferssi' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target Heal' FROM heroes WHERE name = 'Ferssi' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Ferssi' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Ferssi' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Filippa
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Filippa', 'filippa', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Filippa' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Filippa' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Filippa' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Gale
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Gale', 'gale', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Gale' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Gale' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Garroq
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Garroq', 'garroq', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Grey Blades' FROM heroes WHERE name = 'Garroq' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Grey Blades');

-- Герой: Ghorza
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Ghorza', 'ghorza', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Ghorza' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Ghorza' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Gisele
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Gisele', 'gisele', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Gisele' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Gisele' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Gisele' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');

-- Герой: Glacius
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Glacius', 'glacius', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Glacius' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Glacius' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Glacius' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Glacius' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Glen
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Glen', 'glen', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Glen' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');

-- Герой: Gluttony
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Gluttony', 'gluttony', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Gluttony' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Gluttony' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Gluttony' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');

-- Герой: Gnash
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Gnash', 'gnash', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Gnash' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Gnash' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');

-- Герой: Gogran
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Gogran', 'gogran', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Gogran' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Gogran' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Gonkba
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Gonkba', 'gonkba', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Gonkba' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Gonkba' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');

-- Герой: Graves Greybeard
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Graves Greybeard', 'graves_greybeard', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Graves Greybeard' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Graves Greybeard' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Graves Greybeard' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Graves Greybeard' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Greed
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Greed', 'greed', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Greed' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Greed' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Greed' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Greed' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Gretchen
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Gretchen', 'gretchen', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Gretchen' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Gretchen' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Gretchen' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'DEF Penetration' FROM heroes WHERE name = 'Gretchen' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'DEF Penetration');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Gretchen' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Offensive Dispel' FROM heroes WHERE name = 'Gretchen' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Offensive Dispel');

-- Герой: Gu Shi
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Gu Shi', 'gu_shi', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Gu Shi' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Gu Shi' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'DEF Penetration' FROM heroes WHERE name = 'Gu Shi' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'DEF Penetration');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Offensive Dispel' FROM heroes WHERE name = 'Gu Shi' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Offensive Dispel');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Gu Shi' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Dual-Target ATK' FROM heroes WHERE name = 'Gu Shi' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Dual-Target ATK');

-- Герой: Guan Yu
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Guan Yu', 'guan_yu', 'Tactician', 'tactician') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Guan Yu' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Guan Yu' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Displacement' FROM heroes WHERE name = 'Guan Yu' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Displacement');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Guan Yu' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'DEF Penetration' FROM heroes WHERE name = 'Guan Yu' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'DEF Penetration');

-- Герой: Gul''Drak
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Gul''Drak', 'gul%27drak', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Gul''Drak' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Gul''Drak' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Gul''Drak' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Summon' FROM heroes WHERE name = 'Gul''Drak' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Summon');

-- Герой: Gwendolyn
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Gwendolyn', 'gwendolyn', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Gwendolyn' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target Heal' FROM heroes WHERE name = 'Gwendolyn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Gwendolyn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Gwendolyn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');

-- Герой: Halder
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Halder', 'halder', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Halder' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Cost Regen' FROM heroes WHERE name = 'Halder' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Cost Regen');

-- Герой: Harpun
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Harpun', 'harpun', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Harpun' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Harpun' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Harpun' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Hatssut
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Hatssut', 'hatssut', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Hatssut' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Hatssut' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Hatssut' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Invisibility' FROM heroes WHERE name = 'Hatssut' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Invisibility');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Hatssut' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Hayden
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Hayden', 'hayden', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Hayden' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Cost Regen' FROM heroes WHERE name = 'Hayden' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Cost Regen');

-- Герой: Helga
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Helga', 'helga', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Helga' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Helga' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Helga' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Helga' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Helga' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Hex
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Hex', 'hex', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Hex' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Hex' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Hex' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Hex' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Invisibility' FROM heroes WHERE name = 'Hex' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Invisibility');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Hex' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Hollow
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Hollow', 'hollow', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Hollow' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target Heal' FROM heroes WHERE name = 'Hollow' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Hollow' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Rage Regen' FROM heroes WHERE name = 'Hollow' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Rage Regen');

-- Герой: Idril
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Idril', 'idril', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Idril' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Idril' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Idril' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Idril' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Idril' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Imani
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Imani', 'imani', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Imani' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Imani' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Imani' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Init
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Init', 'init', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Supreme Arbiter' FROM heroes WHERE name = 'Init' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Supreme Arbiter');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Init' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Init' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Init' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Init' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Init' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Janqhar
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Janqhar', 'janqhar', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Janqhar' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Janqhar' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Janqhar' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');

-- Герой: Janus Grismore
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Janus Grismore', 'janus_grismore', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Janus Grismore' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Janus Grismore' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Summon' FROM heroes WHERE name = 'Janus Grismore' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Summon');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Offensive Dispel' FROM heroes WHERE name = 'Janus Grismore' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Offensive Dispel');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Janus Grismore' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Jeera
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Jeera', 'jeera', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Supreme Arbiter' FROM heroes WHERE name = 'Jeera' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Supreme Arbiter');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Jeera' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'DEF Penetration' FROM heroes WHERE name = 'Jeera' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'DEF Penetration');

-- Герой: Jonas
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Jonas', 'jonas', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Jonas' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');

-- Герой: Jorge
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Jorge', 'jorge', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Jorge' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Jorge' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Jorge' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');

-- Герой: Josh
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Josh', 'josh', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Josh' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Josh' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Kaede
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Kaede', 'kaede', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Kaede' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Kaede' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Kaede' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Summon' FROM heroes WHERE name = 'Kaede' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Summon');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Kaede' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Kaede' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Kai
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Kai', 'kai', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Kai' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Kai' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Kai' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Kai' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Kai' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Kalina
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Kalina', 'kalina', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Kalina' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Kalina' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'True DMG' FROM heroes WHERE name = 'Kalina' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'True DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Kalina' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Kane
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Kane', 'kane', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Supreme Arbiter' FROM heroes WHERE name = 'Kane' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Supreme Arbiter');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Kane' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Cost Regen' FROM heroes WHERE name = 'Kane' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Cost Regen');

-- Герой: Kassandra
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Kassandra', 'kassandra', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Supreme Arbiter' FROM heroes WHERE name = 'Kassandra' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Supreme Arbiter');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Kassandra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'DEF Penetration' FROM heroes WHERE name = 'Kassandra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'DEF Penetration');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Kassandra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Kassandra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Defensive Dispel' FROM heroes WHERE name = 'Kassandra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Defensive Dispel');

-- Герой: Khadgrim
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Khadgrim', 'khadgrim', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Khadgrim' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Khadgrim' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Khadgrim' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Khadgrim' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');

-- Герой: Khamet
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Khamet', 'khamet', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Khamet' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Khamet' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Khamet' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Kigiri
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Kigiri', 'kigiri', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Kigiri' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Kigiri' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Offensive Dispel' FROM heroes WHERE name = 'Kigiri' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Offensive Dispel');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Kigiri' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');

-- Герой: Kineza
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Kineza', 'kineza', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Kineza' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Kineza' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Kineza' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');

-- Герой: Knight Arlott
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Knight Arlott', 'knight_arlott', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Knight Arlott' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Knight Arlott' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'High Block' FROM heroes WHERE name = 'Knight Arlott' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'High Block');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Knight Arlott' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');

-- Герой: Komodo
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Komodo', 'komodo', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Komodo' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Komodo' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Komodo' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');

-- Герой: Kria
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Kria', 'kria', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Kria' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Kria' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Summon' FROM heroes WHERE name = 'Kria' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Summon');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Kria' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Krodor
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Krodor', 'krodor', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Krodor' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'High Block' FROM heroes WHERE name = 'Krodor' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'High Block');

-- Герой: Lady Alexandra
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Lady Alexandra', 'lady_alexandra', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Lady Alexandra' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Lady Alexandra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Lady Alexandra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'DEF Penetration' FROM heroes WHERE name = 'Lady Alexandra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'DEF Penetration');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Lady Alexandra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Lady Mina
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Lady Mina', 'lady_mina', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Lady Mina' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Lady Mina' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Lady Mina' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Lady Mina' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Lady Mina' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Lancer
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Lancer', 'lancer', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Lancer' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Lancer' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');

-- Герой: Langlyn
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Langlyn', 'langlyn', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Langlyn' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');

-- Герой: Laseer
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Laseer', 'laseer', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Laseer' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Laseer' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Healing' FROM heroes WHERE name = 'Laseer' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Healing');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Laseer' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Laseer' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Laurel
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Laurel', 'laurel', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Laurel' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Laurel' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Rage Regen' FROM heroes WHERE name = 'Laurel' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Rage Regen');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Laurel' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Leikan
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Leikan', 'leikan', 'Tactician', 'tactician') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Leikan' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Leikan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Displacement' FROM heroes WHERE name = 'Leikan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Displacement');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Leikan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Leikan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Liam
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Liam', 'liam', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Liam' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Liam' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Liam' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Liam' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Lightlocke
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Lightlocke', 'lightlocke', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Lightlocke' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target Heal' FROM heroes WHERE name = 'Lightlocke' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target Heal');

-- Герой: Lili
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Lili', 'lili', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Lili' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target Heal' FROM heroes WHERE name = 'Lili' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Lili' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');

-- Герой: Lilia
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Lilia', 'lilia', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Lilia' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Cost Regen' FROM heroes WHERE name = 'Lilia' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Cost Regen');

-- Герой: Livian
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Livian', 'livian', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Livian' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Livian' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Livian' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');

-- Герой: Lord Phineas
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Lord Phineas', 'lord_phineas', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Lord Phineas' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Lord Phineas' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Lord Phineas' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Lord Phineas' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Lu Bu
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Lu Bu', 'lu_bu', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Lu Bu' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Lu Bu' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Lu Bu' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Lu Bu' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');

-- Герой: Lucius
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Lucius', 'lucius', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Lucius' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Lucius' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Offensive Dispel' FROM heroes WHERE name = 'Lucius' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Offensive Dispel');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Lucius' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Lugaru
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Lugaru', 'lugaru', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Lugaru' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Lugaru' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Lugaru' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Lugaru' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');

-- Герой: Lulu
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Lulu', 'lulu', 'Tactician', 'tactician') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Lulu' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Lulu' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Lulu' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Displacement' FROM heroes WHERE name = 'Lulu' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Displacement');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Lulu' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');

-- Герой: Lust
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Lust', 'lust', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Lust' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Lust' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Lust' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Lust' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Lynx
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Lynx', 'lynx', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Lynx' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Lynx' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Lynx' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Lynx' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Lyra
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Lyra', 'lyra', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Lyra' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Lyra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Lyra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Offensive Dispel' FROM heroes WHERE name = 'Lyra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Offensive Dispel');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Lyra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Magda
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Magda', 'magda', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Magda' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Magda' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Magda' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Magmus
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Magmus', 'magmus', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Magmus' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Magmus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'High Block' FROM heroes WHERE name = 'Magmus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'High Block');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Magmus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Malrik
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Malrik', 'malrik', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Malrik' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Malrik' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Malrik' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Malrik' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Malrik' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Malrik' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Malvira
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Malvira', 'malvira', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Malvira' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Malvira' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Malvira' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'High Block' FROM heroes WHERE name = 'Malvira' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'High Block');

-- Герой: Marri
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Marri', 'marri', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Marri' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Marri' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Marri' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Marri' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Marri' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Maul
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Maul', 'maul', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Maul' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Maul' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Maul' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Maul' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Maw
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Maw', 'maw', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Maw' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Maw' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Maw' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');

-- Герой: Meriel
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Meriel', 'meriel', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Meriel' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target Heal' FROM heroes WHERE name = 'Meriel' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target Heal');

-- Герой: Midan
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Midan', 'midan', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Midan' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE Heal' FROM heroes WHERE name = 'Midan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Defensive Dispel' FROM heroes WHERE name = 'Midan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Defensive Dispel');

-- Герой: Morene
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Morene', 'morene', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Morene' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Morene' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Morene' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Morene' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Moriden
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Moriden', 'moriden', 'Tactician', 'tactician') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Moriden' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Moriden' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Displacement' FROM heroes WHERE name = 'Moriden' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Displacement');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Moriden' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Rage Regen' FROM heroes WHERE name = 'Moriden' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Rage Regen');

-- Герой: Myca
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Myca', 'myca', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Myca' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Myca' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'DEF Penetration' FROM heroes WHERE name = 'Myca' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'DEF Penetration');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Myca' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Myca' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Narvi
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Narvi', 'narvi', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Narvi' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Cost Regen' FROM heroes WHERE name = 'Narvi' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Cost Regen');

-- Герой: Nauvras
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Nauvras', 'nauvras', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Nauvras' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Nauvras' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Summon' FROM heroes WHERE name = 'Nauvras' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Summon');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Nauvras' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Nazeem
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Nazeem', 'nazeem', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Nazeem' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Nazeem' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Nazeem' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Nazeem' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Nazeem' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Ne Zha
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Ne Zha', 'ne_zha', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Ne Zha' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Ne Zha' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Ne Zha' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'DEF Penetration' FROM heroes WHERE name = 'Ne Zha' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'DEF Penetration');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Ne Zha' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Ne Zha' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Nerissa
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Nerissa', 'nerissa', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Nerissa' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target Heal' FROM heroes WHERE name = 'Nerissa' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Nerissa' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Nerissa' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Defensive Dispel' FROM heroes WHERE name = 'Nerissa' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Defensive Dispel');

-- Герой: Niro
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Niro', 'niro', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Niro' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Niro' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Niro' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Nisalt
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Nisalt', 'nisalt', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Nisalt' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Nisalt' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Nisalt' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Nisalt' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Nissandei
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Nissandei', 'nissandei', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Nissandei' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE Heal' FROM heroes WHERE name = 'Nissandei' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Defensive Dispel' FROM heroes WHERE name = 'Nissandei' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Defensive Dispel');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Nissandei' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Nocturne
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Nocturne', 'nocturne', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Nocturne' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Nocturne' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'True DMG' FROM heroes WHERE name = 'Nocturne' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'True DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Nocturne' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Numera
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Numera', 'numera', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Numera' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Numera' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Numera' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Numera' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Numera' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Nunea
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Nunea', 'nunea', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Nunea' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target Heal' FROM heroes WHERE name = 'Nunea' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Nunea' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');

-- Герой: Nyx
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Nyx', 'nyx', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Nyx' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Nyx' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Nyx' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Nyx' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Oakenvar
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Oakenvar', 'oakenvar', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Oakenvar' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Oakenvar' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Oakenvar' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');

-- Герой: Ogrul
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Ogrul', 'ogrul', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Ogrul' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Ogrul' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');

-- Герой: Olague
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Olague', 'olague', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Olague' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Olague' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');

-- Герой: Orim
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Orim', 'orim', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Orim' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Orim' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Orim' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');

-- Герой: Osiren
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Osiren', 'osiren', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Osiren' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Osiren' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Osiren' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Pelagios
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Pelagios', 'pelagios', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Supreme Arbiter' FROM heroes WHERE name = 'Pelagios' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Supreme Arbiter');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Pelagios' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Pelagios' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'True DMG' FROM heroes WHERE name = 'Pelagios' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'True DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Pelagios' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Pierre
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Pierre', 'pierre', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Pierre' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Pierre' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Pierre' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Summon' FROM heroes WHERE name = 'Pierre' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Summon');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Pierre' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');

-- Герой: Preter
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Preter', 'preter', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Preter' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');

-- Герой: Raizan
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Raizan', 'raizan', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Raizan' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Raizan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Raizan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Raizan' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Razaak
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Razaak', 'razaak', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Razaak' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Razaak' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Razaak' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Razaak' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Regulus
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Regulus', 'regulus', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Regulus' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Regulus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Regulus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');

-- Герой: Rex
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Rex', 'rex', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Rex' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Rex' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');

-- Герой: Rhox
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Rhox', 'rhox', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Rhox' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Rhox' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'High Block' FROM heroes WHERE name = 'Rhox' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'High Block');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Rhox' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');

-- Герой: Rhutu
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Rhutu', 'rhutu', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Rhutu' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Cost Regen' FROM heroes WHERE name = 'Rhutu' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Cost Regen');

-- Герой: Rogers
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Rogers', 'rogers', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Rogers' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');

-- Герой: Rorkesh
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Rorkesh', 'rorkesh', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Grey Blades' FROM heroes WHERE name = 'Rorkesh' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Grey Blades');

-- Герой: Rosalia
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Rosalia', 'rosalia', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Rosalia' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Rosalia' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Rosalia' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Rosalia' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');

-- Герой: Ruen Hollow
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Ruen Hollow', 'ruen_hollow', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Ruen Hollow' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Ruen Hollow' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Ruen Hollow' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Ruen Hollow' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Ruen Hollow' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Rum-Nose
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Rum-Nose', 'rum-nose', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Rum-Nose' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');

-- Герой: Ryder
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Ryder', 'ryder', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Ryder' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Cost Regen' FROM heroes WHERE name = 'Ryder' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Cost Regen');

-- Герой: Sadie
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Sadie', 'sadie', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Sadie' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE Heal' FROM heroes WHERE name = 'Sadie' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Sadie' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');

-- Герой: Salazar
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Salazar', 'salazar', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Salazar' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Salazar' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Salazar' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Salazar' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');

-- Герой: Sargak
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Sargak', 'sargak', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Sargak' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Sargak' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Sargak' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Sargak' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'DEF Penetration' FROM heroes WHERE name = 'Sargak' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'DEF Penetration');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Sargak' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Scorch
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Scorch', 'scorch', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Scorch' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Scorch' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');

-- Герой: Selene
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Selene', 'selene', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Selene' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Selene' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Selene' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');

-- Герой: Selkath
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Selkath', 'selkath', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Selkath' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Selkath' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Selkath' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Selkath' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Serephina
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Serephina', 'serephina', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Serephina' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Serephina' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Serephina' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Sergei
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Sergei', 'sergei', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Sergei' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Sergei' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Sergei' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'DEF Penetration' FROM heroes WHERE name = 'Sergei' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'DEF Penetration');

-- Герой: Setram
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Setram', 'setram', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Setram' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Setram' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Setram' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Setram' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Setram' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Setram' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Shamir
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Shamir', 'shamir', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Shamir' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Shamir' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Shamir' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Shelor
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Shelor', 'shelor', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Shelor' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Shelor' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');

-- Герой: Silas
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Silas', 'silas', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Silas' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Silas' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'DEF Penetration' FROM heroes WHERE name = 'Silas' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'DEF Penetration');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Silas' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Skreef
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Skreef', 'skreef', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Skreef' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');

-- Герой: Skulf
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Skulf', 'skulf', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Skulf' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Skulf' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');

-- Герой: Solaris Skyre
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Solaris Skyre', 'solaris_skyre', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Solaris Skyre' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Solaris Skyre' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Solaris Skyre' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Solaris Skyre' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Soleil
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Soleil', 'soleil', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Soleil' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Soleil' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Soleil' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Sorzus
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Sorzus', 'sorzus', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Sorzus' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Sorzus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');

-- Герой: Spring
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Spring', 'spring', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Spring' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target Heal' FROM heroes WHERE name = 'Spring' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target Heal');

-- Герой: Su Yue
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Su Yue', 'su_yue', 'Tactician', 'tactician') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Supreme Arbiter' FROM heroes WHERE name = 'Su Yue' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Supreme Arbiter');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Su Yue' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Fast Revival' FROM heroes WHERE name = 'Su Yue' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Fast Revival');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'True DMG' FROM heroes WHERE name = 'Su Yue' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'True DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'DEF Penetration' FROM heroes WHERE name = 'Su Yue' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'DEF Penetration');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Su Yue' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Sun Wukong
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Sun Wukong', 'sun_wukong', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Sun Wukong' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Sun Wukong' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Sun Wukong' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Sun Wukong' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Summon' FROM heroes WHERE name = 'Sun Wukong' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Summon');

-- Герой: Sythra
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Sythra', 'sythra', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Sythra' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Sythra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'DEF Penetration' FROM heroes WHERE name = 'Sythra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'DEF Penetration');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Summon' FROM heroes WHERE name = 'Sythra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Summon');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Sythra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Talin
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Talin', 'talin', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Watchguard' FROM heroes WHERE name = 'Talin' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Watchguard');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Talin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Talin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Offensive Dispel' FROM heroes WHERE name = 'Talin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Offensive Dispel');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Talin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Talin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Talula
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Talula', 'talula', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Talula' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE Heal' FROM heroes WHERE name = 'Talula' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE Heal');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Defensive Dispel' FROM heroes WHERE name = 'Talula' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Defensive Dispel');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Talula' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Talula' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');

-- Герой: Tazira
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Tazira', 'tazira', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Tazira' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Tazira' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Tazira' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Tazira' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Thallen
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Thallen', 'thallen', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Supreme Arbiter' FROM heroes WHERE name = 'Thallen' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Supreme Arbiter');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Thallen' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Thallen' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Thallen' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Thallen' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');

-- Герой: Theowin
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Theowin', 'theowin', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Theowin' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Theowin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Theowin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Thunkles
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Thunkles', 'thunkles', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Thunkles' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Thunkles' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Healing' FROM heroes WHERE name = 'Thunkles' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Healing');

-- Герой: Titus
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Titus', 'titus', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Titus' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Titus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');

-- Герой: Trusk
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Trusk', 'trusk', 'Defender', 'defender') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Trusk' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'High Block' FROM heroes WHERE name = 'Trusk' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'High Block');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Trusk' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');

-- Герой: Twyla
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Twyla', 'twyla', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Twyla' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Twyla' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Twyla' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'DEF Penetration' FROM heroes WHERE name = 'Twyla' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'DEF Penetration');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Twyla' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');

-- Герой: Uredin
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Uredin', 'uredin', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Uredin' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Uredin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Uredin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Uredin' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');

-- Герой: Valara
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Valara', 'valara', 'Tactician', 'tactician') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Supreme Arbiter' FROM heroes WHERE name = 'Valara' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Supreme Arbiter');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Valara' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Displacement' FROM heroes WHERE name = 'Valara' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Displacement');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'True DMG' FROM heroes WHERE name = 'Valara' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'True DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Invisibility' FROM heroes WHERE name = 'Valara' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Invisibility');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Valara' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Valeriya
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Valeriya', 'valeriya', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Valeriya' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Valeriya' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Valeriya' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Durability' FROM heroes WHERE name = 'Valeriya' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Durability');

-- Герой: Valkyra
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Valkyra', 'valkyra', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Valkyra' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Valkyra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Valkyra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Valkyra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Range Boost' FROM heroes WHERE name = 'Valkyra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Range Boost');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Valkyra' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Vargus
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Vargus', 'vargus', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Vargus' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Vargus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Invisibility' FROM heroes WHERE name = 'Vargus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Invisibility');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Vargus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Varro Draccus
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Varro Draccus', 'varro_draccus', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Chaos Dominion' FROM heroes WHERE name = 'Varro Draccus' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Chaos Dominion');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Varro Draccus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Varro Draccus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Summon' FROM heroes WHERE name = 'Varro Draccus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Summon');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Varro Draccus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Velisse
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Velisse', 'velisse', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Velisse' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Velisse' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Velisse' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Summon' FROM heroes WHERE name = 'Velisse' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Summon');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Velisse' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Vera
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Vera', 'vera', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Vera' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Vera' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'DEF Penetration' FROM heroes WHERE name = 'Vera' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'DEF Penetration');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Vera' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Vierna
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Vierna', 'vierna', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Vierna' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Vierna' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Vierna' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Vierna' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Violetta Vane
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Violetta Vane', 'violetta_vane', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Violetta Vane' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Violetta Vane' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Violetta Vane' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Violetta Vane' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Violetta Vane' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Vlad Draculea
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Vlad Draculea', 'vlad_draculea', 'Tactician', 'tactician') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Vlad Draculea' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Vlad Draculea' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Displacement' FROM heroes WHERE name = 'Vlad Draculea' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Displacement');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'High Block' FROM heroes WHERE name = 'Vlad Draculea' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'High Block');

-- Герой: Volka
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Volka', 'volka', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Volka' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Volka' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Volka' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Team Protection' FROM heroes WHERE name = 'Volka' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Team Protection');

-- Герой: Voltus
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Voltus', 'voltus', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Voltus' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Voltus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Voltus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Vorn
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Vorn', 'vorn', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Star Piercers' FROM heroes WHERE name = 'Vorn' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Star Piercers');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Vorn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Vorn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Vorn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Offensive Dispel' FROM heroes WHERE name = 'Vorn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Offensive Dispel');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Vorn' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Voroth
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Voroth', 'voroth', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Voroth' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Voroth' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Voroth' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');

-- Герой: Vortex
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Vortex', 'vortex', 'Healer', 'healer') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'North Throne' FROM heroes WHERE name = 'Vortex' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'North Throne');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target Heal' FROM heroes WHERE name = 'Vortex' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target Heal');

-- Герой: Wagrak
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Wagrak', 'wagrak', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Faction' FROM heroes WHERE name = 'Wagrak' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Faction');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Wagrak' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Wagrak' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Xaris
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Xaris', 'xaris', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Xaris' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Xaris' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Summon' FROM heroes WHERE name = 'Xaris' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Summon');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Xaris' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Xasny
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Xasny', 'xasny', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Esoteria Order' FROM heroes WHERE name = 'Xasny' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Esoteria Order');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Xasny' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Offensive Dispel' FROM heroes WHERE name = 'Xasny' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Offensive Dispel');

-- Герой: Xena
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Xena', 'xena', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Xena' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Xena' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Xena' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');

-- Герой: Ymiret
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Ymiret', 'ymiret', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Unnamable' FROM heroes WHERE name = 'Ymiret' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Unnamable');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE P. ATK' FROM heroes WHERE name = 'Ymiret' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Strong CC' FROM heroes WHERE name = 'Ymiret' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Strong CC');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Ymiret' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Yuri
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Yuri', 'yuri', 'Marksman', 'marksman') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Nightmare Council' FROM heroes WHERE name = 'Yuri' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Nightmare Council');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target P. ATK' FROM heroes WHERE name = 'Yuri' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target P. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Multi-Strike ATK' FROM heroes WHERE name = 'Yuri' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Multi-Strike ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Yuri' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Zelus
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Zelus', 'zelus', 'Mage', 'mage') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Cursed Cult' FROM heroes WHERE name = 'Zelus' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Cursed Cult');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'AoE M. ATK' FROM heroes WHERE name = 'Zelus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'AoE M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Ally Buff' FROM heroes WHERE name = 'Zelus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Ally Buff');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Zelus' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

-- Герой: Zilitu
INSERT INTO heroes (name, image_slug, class_name, class_icon_slug) VALUES ('Zilitu', 'zilitu', 'Fighter', 'fighter') ON CONFLICT (name) DO NOTHING;
INSERT INTO hero_faction_list (hero_id, faction_name) SELECT id, 'Infernal Blast' FROM heroes WHERE name = 'Zilitu' AND NOT EXISTS (SELECT 1 FROM hero_faction_list WHERE hero_id = heroes.id AND faction_name = 'Infernal Blast');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Single-Target M. ATK' FROM heroes WHERE name = 'Zilitu' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Single-Target M. ATK');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Continuous DMG' FROM heroes WHERE name = 'Zilitu' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Continuous DMG');
INSERT INTO hero_tags (hero_id, tag) SELECT id, 'Anti-Air' FROM heroes WHERE name = 'Zilitu' AND NOT EXISTS (SELECT 1 FROM hero_tags WHERE hero_id = heroes.id AND tag = 'Anti-Air');

ALTER TABLE heroes ADD COLUMN IF NOT EXISTS rarity VARCHAR(50) DEFAULT 'Unknown';