-- ============================================================
-- Автоматично згенерована міграція фракцій героїв
-- ============================================================
-- Дублікати героїв та фракцій об'єднані Node.js.
-- Існуючі записи в БД не дублюються.
-- ============================================================

-- Герой: Abyzou
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult Lord')
) AS v(faction_name)
WHERE h.name = 'Abyzou'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Aeon
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult Lord')
) AS v(faction_name)
WHERE h.name = 'Aeon'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Ain
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard Lord')
) AS v(faction_name)
WHERE h.name = 'Ain'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Amelia Ainsworth
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Grey Blades Lord')
) AS v(faction_name)
WHERE h.name = 'Amelia Ainsworth'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Aracha
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers Lord')
) AS v(faction_name)
WHERE h.name = 'Aracha'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Borut
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard Lord')
) AS v(faction_name)
WHERE h.name = 'Borut'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Cyrus
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order Lord')
) AS v(faction_name)
WHERE h.name = 'Cyrus'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Dagna
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne Lord')
) AS v(faction_name)
WHERE h.name = 'Dagna'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Demi
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult Lord')
) AS v(faction_name)
WHERE h.name = 'Demi'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Elddr
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne Lord')
) AS v(faction_name)
WHERE h.name = 'Elddr'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Eliza
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers Lord')
) AS v(faction_name)
WHERE h.name = 'Eliza'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Elysia
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Supreme Arbiter Lord')
) AS v(faction_name)
WHERE h.name = 'Elysia'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Ezareth
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult Lord')
) AS v(faction_name)
WHERE h.name = 'Ezareth'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Galloway
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Grey Blades Lord')
) AS v(faction_name)
WHERE h.name = 'Galloway'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Ghan
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion Lord')
) AS v(faction_name)
WHERE h.name = 'Ghan'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Ingrid
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard Lord'),
        ('Supreme Arbiter')
) AS v(faction_name)
WHERE h.name = 'Ingrid'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Iovar
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers Lord')
) AS v(faction_name)
WHERE h.name = 'Iovar'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Isolde
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne Lord')
) AS v(faction_name)
WHERE h.name = 'Isolde'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Jezebelle
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion Lord')
) AS v(faction_name)
WHERE h.name = 'Jezebelle'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: King Harz
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne Lord')
) AS v(faction_name)
WHERE h.name = 'King Harz'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Laya
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard Lord')
) AS v(faction_name)
WHERE h.name = 'Laya'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Luneria
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers Lord')
) AS v(faction_name)
WHERE h.name = 'Luneria'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Morrigan
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult Lord')
) AS v(faction_name)
WHERE h.name = 'Morrigan'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Nastya
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order Lord')
) AS v(faction_name)
WHERE h.name = 'Nastya'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Oren
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Supreme Arbiter Lord')
) AS v(faction_name)
WHERE h.name = 'Oren'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Praetus
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Supreme Arbiter Lord')
) AS v(faction_name)
WHERE h.name = 'Praetus'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Pyros
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast Lord')
) AS v(faction_name)
WHERE h.name = 'Pyros'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Raiden
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order Lord')
) AS v(faction_name)
WHERE h.name = 'Raiden'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Rivenhald
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne Lord')
) AS v(faction_name)
WHERE h.name = 'Rivenhald'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Rork
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne Lord')
) AS v(faction_name)
WHERE h.name = 'Rork'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Rygar
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council Lord')
) AS v(faction_name)
WHERE h.name = 'Rygar'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Solcadens
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast Lord')
) AS v(faction_name)
WHERE h.name = 'Solcadens'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Torodor
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council Lord')
) AS v(faction_name)
WHERE h.name = 'Torodor'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Twinfiend
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast Lord')
) AS v(faction_name)
WHERE h.name = 'Twinfiend'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Valderon
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion Lord')
) AS v(faction_name)
WHERE h.name = 'Valderon'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Venoma
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order Lord')
) AS v(faction_name)
WHERE h.name = 'Venoma'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Veyrathia
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council Lord')
) AS v(faction_name)
WHERE h.name = 'Veyrathia'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Vixera
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order Lord')
) AS v(faction_name)
WHERE h.name = 'Vixera'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Vladov
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion Lord'),
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Vladov'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Wrath
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council Lord')
) AS v(faction_name)
WHERE h.name = 'Wrath'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Abomination
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Abomination'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Admiral Claw
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Admiral Claw'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Aedrin
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Aedrin'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Aeris
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard'),
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Aeris'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Ai
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order'),
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Ai'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Ajax
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Unnamable')
) AS v(faction_name)
WHERE h.name = 'Ajax'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Akira
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers'),
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Akira'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Alaura
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard'),
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Alaura'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Alistair
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Supreme Arbiter'),
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Alistair'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Amahle
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Amahle'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Anai
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Anai'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Anora
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult'),
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Anora'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Apsan
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Apsan'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Ardea
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Ardea'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Ardeth
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Ardeth'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Ares
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Ares'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Arlow
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Arlow'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Arrogance
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Arrogance'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Artemis
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Artemis'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Aryn
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Aryn'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Astrael
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne'),
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Astrael'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Atrox
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult'),
        ('Chaos Dominion')
) AS v(faction_name)
WHERE h.name = 'Atrox'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Aurelius Gale
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Aurelius Gale'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Autumn
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Autumn'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Aveline
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne'),
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Aveline'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Aylin
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Aylin'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Azhor
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Azhor'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Azzoth
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Azzoth'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Barclay
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Barclay'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Baron
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Baron'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Bayek
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers'),
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Bayek'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Beatrix
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult'),
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Beatrix'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Beelzebub
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Beelzebub'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Boreas
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order'),
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Boreas'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Brienne
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard'),
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Brienne'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Brokkir
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Brokkir'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Brunor
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne'),
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Brunor'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Cainan
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard'),
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Cainan'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Calista
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Calista'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Calypso
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Calypso'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Camille
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Camille'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Captain Reve
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Captain Reve'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Carnelian
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Carnelian'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Carosa
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Carosa'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Cassiel
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Supreme Arbiter'),
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Cassiel'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Cerberus
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult'),
        ('Chaos Dominion')
) AS v(faction_name)
WHERE h.name = 'Cerberus'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Clarissa
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Clarissa'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Constance
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard'),
        ('Supreme Arbiter')
) AS v(faction_name)
WHERE h.name = 'Constance'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Corven
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers'),
        ('Grey Blades')
) AS v(faction_name)
WHERE h.name = 'Corven'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Count Dracula
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Count Dracula'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Crach
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Crach'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Cuke
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Cuke'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Cutter
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Cutter'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Cyclone
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Cyclone'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Cyrene
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard'),
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Cyrene'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Daemon
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Daemon'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Dahlia
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult'),
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Dahlia'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Dalyn
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Dalyn'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Dane
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Dane'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Dassomi
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Dassomi'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Decimus
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Decimus'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Deimos
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Deimos'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Diaochan
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard'),
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Diaochan'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Dolores
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Dolores'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Dr. Van Helsing
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers'),
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Dr. Van Helsing'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Draelyn
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard'),
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Draelyn'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Drayga
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Drayga'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Duradel
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Duradel'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Durza
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Durza'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Edith
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Edith'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Eirlys
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard'),
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Eirlys'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Eivor Varinsdottir
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard'),
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Eivor Varinsdottir'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Elowyn
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Elowyn'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Elukas
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Elukas'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Eona
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult'),
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Eona'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Erlang Shen
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Supreme Arbiter'),
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Erlang Shen'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Esme
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Esme'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Estrid
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Estrid'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Eunomia
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Supreme Arbiter'),
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Eunomia'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Evie Frye
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Evie Frye'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Ezio Auditore
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Supreme Arbiter'),
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Ezio Auditore'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Ezio Della Notte
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Ezio Della Notte'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Ezryn
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Ezryn'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Faelin
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Faelin'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Falcia
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne'),
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Falcia'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Fenris
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Fenris'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Ferssi
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Ferssi'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Filippa
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Filippa'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Gale
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Gale'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Garroq
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Grey Blades'),
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Garroq'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Ghorza
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Ghorza'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Gisele
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Gisele'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Glacius
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Glacius'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Glen
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Glen'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Gluttony
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Gluttony'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Gnash
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Gnash'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Gogran
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Gogran'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Gonkba
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Gonkba'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Graves Greybeard
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Graves Greybeard'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Greed
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council'),
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Greed'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Gretchen
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Gretchen'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Gu Shi
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers'),
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Gu Shi'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Guan Yu
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard'),
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Guan Yu'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Gul'Drak
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Gul''Drak'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Gwendolyn
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Gwendolyn'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Halder
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Halder'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Harpun
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Harpun'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Hatssut
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Hatssut'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Hayden
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Hayden'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Helga
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Helga'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Hex
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast'),
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Hex'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Hollow
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Hollow'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Idril
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers'),
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Idril'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Imani
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Imani'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Init
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Supreme Arbiter'),
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Init'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Janqhar
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Janqhar'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Janus Grismore
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Janus Grismore'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Jeera
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Supreme Arbiter'),
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Jeera'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Jonas
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Jonas'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Jorge
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Jorge'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Josh
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Josh'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Kaede
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Kaede'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Kai
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Kai'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Kalina
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Kalina'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Kane
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Supreme Arbiter'),
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Kane'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Kassandra
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Supreme Arbiter'),
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Kassandra'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Khadgrim
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne'),
        ('Supreme Arbiter')
) AS v(faction_name)
WHERE h.name = 'Khadgrim'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Khamet
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Khamet'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Kigiri
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard'),
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Kigiri'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Kineza
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Kineza'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Knight Arlott
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult'),
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Knight Arlott'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Komodo
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Komodo'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Kria
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Kria'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Krodor
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Krodor'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Lady Alexandra
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers'),
        ('Supreme Arbiter')
) AS v(faction_name)
WHERE h.name = 'Lady Alexandra'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Lady Mina
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne'),
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Lady Mina'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Lancer
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Lancer'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Langlyn
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Langlyn'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Laseer
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Laseer'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Laurel
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Laurel'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Leikan
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council'),
        ('Supreme Arbiter')
) AS v(faction_name)
WHERE h.name = 'Leikan'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Liam
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Liam'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Lightlocke
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard'),
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Lightlocke'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Lili
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order'),
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Lili'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Lilia
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Lilia'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Livian
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard'),
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Livian'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Lord Phineas
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Lord Phineas'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Lu Bu
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne'),
        ('Chaos Dominion')
) AS v(faction_name)
WHERE h.name = 'Lu Bu'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Lucius
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Lucius'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Lugaru
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Lugaru'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Lulu
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Lulu'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Lust
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Lust'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Lynx
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Lynx'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Lyra
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast'),
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Lyra'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Magda
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Magda'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Magmus
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Magmus'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Malrik
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast'),
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Malrik'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Malvira
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne'),
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Malvira'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Marri
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Marri'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Maul
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Maul'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Maw
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Maw'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Meriel
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Meriel'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Midan
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Midan'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Morene
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast'),
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Morene'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Moriden
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council'),
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Moriden'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Myca
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Myca'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Narvi
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Narvi'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Nauvras
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order'),
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Nauvras'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Nazeem
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Nazeem'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Ne Zha
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard'),
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Ne Zha'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Nerissa
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Nerissa'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Niro
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult'),
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Niro'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Nisalt
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Nisalt'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Nissandei
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Nissandei'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Nocturne
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne'),
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Nocturne'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Numera
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers'),
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Numera'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Nunea
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Nunea'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Nyx
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Nyx'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Oakenvar
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Oakenvar'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Ogrul
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Ogrul'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Olague
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Olague'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Orim
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Orim'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Osiren
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Osiren'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Pelagios
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Supreme Arbiter'),
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Pelagios'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Pierre
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult'),
        ('Chaos Dominion')
) AS v(faction_name)
WHERE h.name = 'Pierre'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Preter
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Preter'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Raizan
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Raizan'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Razaak
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Razaak'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Regulus
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Regulus'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Rex
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Rex'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Rhox
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Rhox'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Rhutu
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Rhutu'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Rogers
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Rogers'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Rorkesh
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Grey Blades')
) AS v(faction_name)
WHERE h.name = 'Rorkesh'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Rosalia
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Rosalia'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Ruen Hollow
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers'),
        ('Grey Blades')
) AS v(faction_name)
WHERE h.name = 'Ruen Hollow'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Rum-Nose
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Rum-Nose'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Ryder
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Ryder'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Sadie
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Sadie'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Salazar
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Salazar'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Sargak
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Sargak'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Scorch
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Scorch'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Selene
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Selene'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Selkath
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Selkath'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Serephina
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Serephina'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Sergei
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Sergei'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Setram
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Setram'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Shamir
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Shamir'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Shelor
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Shelor'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Silas
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Silas'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Skreef
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Skreef'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Skulf
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Skulf'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Solaris Skyre
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Solaris Skyre'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Soleil
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard'),
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Soleil'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Sorzus
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Sorzus'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Spring
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Spring'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Su Yue
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Supreme Arbiter'),
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Su Yue'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Sun Wukong
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council'),
        ('Watchguard')
) AS v(faction_name)
WHERE h.name = 'Sun Wukong'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Sythra
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Sythra'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Talin
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Watchguard'),
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Talin'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Talula
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Talula'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Tazira
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Tazira'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Thallen
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Supreme Arbiter'),
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Thallen'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Theowin
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Theowin'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Thunkles
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Thunkles'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Titus
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Titus'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Trusk
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Trusk'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Twyla
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Twyla'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Uredin
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Uredin'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Valara
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Supreme Arbiter'),
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Valara'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Valeriya
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Valeriya'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Valkyra
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne'),
        ('Supreme Arbiter')
) AS v(faction_name)
WHERE h.name = 'Valkyra'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Vargus
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Vargus'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Varro Draccus
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Chaos Dominion'),
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Varro Draccus'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Velisse
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Velisse'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Vera
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Vera'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Vierna
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Vierna'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Violetta Vane
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Violetta Vane'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Vlad Draculea
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Vlad Draculea'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Volka
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council')
) AS v(faction_name)
WHERE h.name = 'Volka'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Voltus
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Voltus'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Vorn
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Star Piercers'),
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Vorn'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Voroth
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Voroth'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Vortex
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('North Throne')
) AS v(faction_name)
WHERE h.name = 'Vortex'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Wagrak
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Faction')
) AS v(faction_name)
WHERE h.name = 'Wagrak'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Xaris
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Xaris'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Xasny
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Esoteria Order')
) AS v(faction_name)
WHERE h.name = 'Xasny'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Xena
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Xena'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Ymiret
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Unnamable')
) AS v(faction_name)
WHERE h.name = 'Ymiret'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Yuri
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Nightmare Council'),
        ('Star Piercers')
) AS v(faction_name)
WHERE h.name = 'Yuri'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Zelus
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Cursed Cult')
) AS v(faction_name)
WHERE h.name = 'Zelus'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );

-- Герой: Zilitu
INSERT INTO hero_faction_list (hero_id, faction_name)
SELECT h.id, v.faction_name
FROM heroes h
CROSS JOIN (
    VALUES
        ('Infernal Blast')
) AS v(faction_name)
WHERE h.name = 'Zilitu'
  AND NOT EXISTS (
      SELECT 1
      FROM hero_faction_list hfl
      WHERE hfl.hero_id = h.id
        AND hfl.faction_name = v.faction_name
  );
