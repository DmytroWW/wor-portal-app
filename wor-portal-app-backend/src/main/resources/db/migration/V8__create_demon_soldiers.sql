CREATE TABLE demon_soldiers (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    rarity VARCHAR(20) NOT NULL,
    faction VARCHAR(50) NOT NULL,
    level INTEGER NOT NULL DEFAULT 1,
    image_slug VARCHAR(100) NOT NULL,

    CONSTRAINT uk_demon_soldier_name UNIQUE (name),
    CONSTRAINT uk_demon_soldier_image_slug UNIQUE (image_slug)
);

INSERT INTO demon_soldiers
    (name, rarity, faction, level, image_slug)
VALUES

-- Frostborne

('Frost Canid', 'LEGENDARY', 'Frostborne Demon Soldiers', 1, 'frost-canid'),
('Frost Guardian', 'LEGENDARY', 'Frostborne Demon Soldiers', 1, 'frost-guardian'),
('Frostbourne Scholar', 'EPIC', 'Frostborne Demon Soldiers', 1, 'frostbourne-scholar'),
('Frozen Cleric', 'LEGENDARY', 'Frostborne Demon Soldiers', 1, 'frozen-cleric'),
('Frozen Drifter', 'EPIC', 'Frostborne Demon Soldiers', 1, 'frozen-drifter'),
('Frozen Raider', 'EPIC', 'Frostborne Demon Soldiers', 1, 'frozen-raider'),
('Glacius (Demon Soldier)', 'LEGENDARY', 'Frostborne Demon Soldiers', 1, 'glacius-demon-soldier'),
('Ice Vermin', 'LEGENDARY', 'Frostborne Demon Soldiers', 1, 'ice-vermin'),

-- Chaos

('Bloodmend Rats', 'LEGENDARY', 'Chaos Demon Soldiers', 1, 'bloodmend-rats'),
('Chaos Shaman', 'EPIC', 'Chaos Demon Soldiers', 1, 'chaos-shaman'),
('Doomripper', 'EPIC', 'Chaos Demon Soldiers', 1, 'doomripper'),
('Emberfire Templar', 'LEGENDARY', 'Chaos Demon Soldiers', 1, 'emberfire-templar'),
('Grotesque Fiend', 'LEGENDARY', 'Chaos Demon Soldiers', 1, 'grotesque-fiend'),
('High-order Abyssal Beholder', 'EPIC', 'Chaos Demon Soldiers', 1, 'high-order-abyssal-beholder'),
('Infernal Cleric', 'EPIC', 'Chaos Demon Soldiers', 1, 'infernal-cleric'),
('Slaughter', 'LEGENDARY', 'Chaos Demon Soldiers', 1, 'slaughter'),

-- Bloodspring

('Baron Salem', 'LEGENDARY', 'Bloodspring Demon Soldiers', 1, 'baron-salem'),
('Batwings Banshee', 'EPIC', 'Bloodspring Demon Soldiers', 1, 'batwings-banshee'),
('Blasting Corpse', 'LEGENDARY', 'Bloodspring Demon Soldiers', 1, 'blasting-corpse'),
('Blood Hexer', 'LEGENDARY', 'Bloodspring Demon Soldiers', 1, 'blood-hexer'),
('Countess Mariath', 'LEGENDARY', 'Bloodspring Demon Soldiers', 1, 'countess-mariath'),
('Specter Skeleton Archer', 'LEGENDARY', 'Bloodspring Demon Soldiers', 1, 'specter-skeleton-archer'),
('Tormented Banshee', 'EPIC', 'Bloodspring Demon Soldiers', 1, 'tormented-banshee'),
('Twisted Sycophant', 'LEGENDARY', 'Bloodspring Demon Soldiers', 1, 'twisted-sycophant'),

-- Stonekin

('Boulder Ravager', 'LEGENDARY', 'Stonekin Demon Soldiers', 1, 'boulder-ravager'),
('Garnet Guard', 'EPIC', 'Stonekin Demon Soldiers', 1, 'garnet-guard'),
('Giant Golem', 'LEGENDARY', 'Stonekin Demon Soldiers', 1, 'giant-golem'),
('Golden Guard', 'EPIC', 'Stonekin Demon Soldiers', 1, 'golden-guard'),
('Ruinstone Drifter', 'EPIC', 'Stonekin Demon Soldiers', 1, 'ruinstone-drifter'),
('Smasher Guard', 'LEGENDARY', 'Stonekin Demon Soldiers', 1, 'smasher-guard'),
('Wasteland Titan (Demon Soldier)', 'LEGENDARY', 'Stonekin Demon Soldiers', 1, 'wasteland-titan-demon-soldier'),

-- Neutral

('Adag''s Follower', 'EPIC', 'Neutral Demon Soldiers', 1, 'adags-follower'),
('Axe Slaughterer', 'EPIC', 'Neutral Demon Soldiers', 1, 'axe-slaughterer'),
('Book Keeper', 'LEGENDARY', 'Neutral Demon Soldiers', 1, 'book-keeper'),
('Carrion Hound', 'RARE', 'Neutral Demon Soldiers', 1, 'carrion-hound'),
('Elite Skeleton Archer', 'RARE', 'Neutral Demon Soldiers', 1, 'elite-skeleton-archer'),
('Fallen Reaper', 'RARE', 'Neutral Demon Soldiers', 1, 'fallen-reaper'),
('Fallen Templar', 'EPIC', 'Neutral Demon Soldiers', 1, 'fallen-templar'),
('Ghoul Hound', 'EPIC', 'Neutral Demon Soldiers', 1, 'ghoul-hound'),
('Imperial Pharaoh Guard', 'EPIC', 'Neutral Demon Soldiers', 1, 'imperial-pharaoh-guard'),
('Knight of Destruction', 'LEGENDARY', 'Neutral Demon Soldiers', 1, 'knight-of-destruction'),
('Lightning Guard', 'LEGENDARY', 'Neutral Demon Soldiers', 1, 'lightning-guard'),
('Lizardfly Imago', 'RARE', 'Neutral Demon Soldiers', 1, 'lizardfly-imago'),
('Maw (Demon Soldier)', 'LEGENDARY', 'Neutral Demon Soldiers', 1, 'maw-demon-soldier'),
('Murkling Menace', 'EPIC', 'Neutral Demon Soldiers', 1, 'murkling-menace'),
('Necromancer', 'EPIC', 'Neutral Demon Soldiers', 1, 'necromancer'),
('Pharaoh''s Guard', 'EPIC', 'Neutral Demon Soldiers', 1, 'pharaohs-guard'),
('Scalekin Champion', 'LEGENDARY', 'Neutral Demon Soldiers', 1, 'scalekin-champion'),
('Scalekin Mage', 'RARE', 'Neutral Demon Soldiers', 1, 'scalekin-mage'),
('Scalekin Shaman', 'EPIC', 'Neutral Demon Soldiers', 1, 'scalekin-shaman'),
('Scalekin Warrior', 'EPIC', 'Neutral Demon Soldiers', 1, 'scalekin-warrior'),
('Scourge', 'EPIC', 'Neutral Demon Soldiers', 1, 'scourge'),
('Shadowcaster', 'EPIC', 'Neutral Demon Soldiers', 1, 'shadowcaster'),
('Skeleton Guardian', 'RARE', 'Neutral Demon Soldiers', 1, 'skeleton-guardian'),
('Small Arachnid', 'RARE', 'Neutral Demon Soldiers', 1, 'small-arachnid'),
('Soulbone Archer', 'EPIC', 'Neutral Demon Soldiers', 1, 'soulbone-archer'),
('Stitched Carrion', 'EPIC', 'Neutral Demon Soldiers', 1, 'stitched-carrion'),
('Suicide', 'EPIC', 'Neutral Demon Soldiers', 1, 'suicide'),
('The Fool', 'LEGENDARY', 'Neutral Demon Soldiers', 1, 'the-fool'),
('Uncommon Destroyer', 'LEGENDARY', 'Neutral Demon Soldiers', 1, 'uncommon-destroyer'),
('White Tower''s Scholar', 'EPIC', 'Neutral Demon Soldiers', 1, 'white-towers-scholar');