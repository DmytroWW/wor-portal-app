

  // =========================================================
  // НОРМАЛІЗАЦІЯ НАЗВИ ФРАКЦІЇ
  // =========================================================

 export const normalizeFaction = (name) => {
    return name
      ?.trim()
      .replace(/\s+/g, ' ');
  };

  // =========================================================
  // ПЕРЕВІРКА ЧИ ФРАКЦІЯ Є LORD
  // =========================================================

 export const isLordFaction = (faction) => {
    return normalizeFaction(faction)
      ?.toLowerCase()
      .endsWith(' lord');
  };

  // =========================================================
  // ОТРИМАТИ БАЗОВУ ФРАКЦІЮ
  // =========================================================

 export const getBaseFaction = (faction) => {
    const normalized = normalizeFaction(faction);

    if (!normalized) {
      return null;
    }

    if (isLordFaction(normalized)) {
      return normalized
        .replace(/\s+Lord$/i, '')
        .trim();
    }

    return normalized;
  };

  // =========================================================
  // ПЕРЕВІРКА НАЛЕЖНОСТІ ГЕРОЯ ДО ФРАКЦІЇ
  // =========================================================

 export const heroBelongsToFaction = (hero, factionName) => {
    if (!Array.isArray(hero.factions)) {
      return false;
    }

    return hero.factions.some((faction) => {
      const normalized = normalizeFaction(faction);

      if (!normalized) {
        return false;
      }

      return getBaseFaction(normalized) === factionName;
    });
  };

  // =========================================================
  // ПЕРЕВІРКА LORD
  // =========================================================

 export const isHeroLordForFaction = (hero, factionName) => {
    if (!Array.isArray(hero.factions)) {
      return false;
    }

    return hero.factions.some((faction) => {
      const normalized = normalizeFaction(faction);

      return (
        isLordFaction(normalized) &&
        getBaseFaction(normalized) === factionName
      );
    });
  };

   // =========================================================
    // НАЗВА ФАЙЛУ ФРАКЦІЇ
    // =========================================================

   export const factionToFileName = (name) => {
      return name
        ?.toLowerCase()
        .trim()
        .replace(/\s+/g, '_');
    };
