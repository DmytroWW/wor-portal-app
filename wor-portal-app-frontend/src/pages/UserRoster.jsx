import React, { useState, useEffect } from 'react';
import api from '../api/axios';

import {
  normalizeFaction,
  isLordFaction,
  getBaseFaction,
  heroBelongsToFaction,
  isHeroLordForFaction,
  factionToFileName
} from '../utils/factionUtils';

const UserRoster = ({ userId }) => {
  const [heroes, setHeroes] = useState([]);
  const [userHeroes, setUserHeroes] = useState({});
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  // =========================================================
  // ФІЛЬТРИ
  // =========================================================

  const [search, setSearch] = useState('');
  const [selectedFaction, setSelectedFaction] = useState('ALL');
  const [selectedRarity, setSelectedRarity] = useState('ALL');

  // =========================================================
  // ЗАВАНТАЖЕННЯ КАТАЛОГУ ГЕРОЇВ ТА РОСТЕРА
  // =========================================================

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      setError(null);

      try {
        const [heroesRes, userHeroesRes] = await Promise.all([
          api.get('/heroes'),
          api.get(`/user-heroes/${userId}`)
        ]);

        setHeroes(heroesRes.data);

        const map = {};

        userHeroesRes.data.forEach((uh) => {
          const heroId = uh.hero?.id ?? uh.heroId;

          if (heroId != null) {
            map[heroId] = uh.awakeningLevel;
          }
        });

        setUserHeroes(map);
      } catch (err) {
        console.error('Помилка завантаження ростера:', err);

        setError(
          err.response?.data?.message ||
          'Не вдалося завантажити ростер.'
        );
      } finally {
        setLoading(false);
      }
    };

    if (userId != null) {
      fetchData();
    } else {
      setLoading(false);
      setError('Не вдалося визначити користувача.');
    }
  }, [userId]);

  // =========================================================
  // ЛКМ — ДОДАВАННЯ / ПІДВИЩЕННЯ ПРОБУДЖЕННЯ
  // =========================================================

  const handleLeftClick = async (heroId) => {
    const previousLevel = userHeroes[heroId] ?? -1;
    const nextLevel = previousLevel < 5 ? previousLevel + 1 : 0;

    setUserHeroes((prev) => ({
      ...prev,
      [heroId]: nextLevel
    }));

    try {
      const response = await api.post(
        `/user-heroes/${userId}/hero/${heroId}`
      );

      setUserHeroes((prev) => ({
        ...prev,
        [heroId]: response.data.awakeningLevel
      }));
    } catch (err) {
      console.error('Помилка оновлення героя:', err);

      setUserHeroes((prev) => {
        const copy = { ...prev };

        if (previousLevel === -1) {
          delete copy[heroId];
        } else {
          copy[heroId] = previousLevel;
        }

        return copy;
      });
    }
  };

  // =========================================================
  // ПКМ — ВИДАЛЕННЯ ГЕРОЯ
  // =========================================================

  const handleRightClick = async (heroId, e) => {
    e.preventDefault();

    const previousLevel = userHeroes[heroId];

    setUserHeroes((prev) => {
      const copy = { ...prev };
      delete copy[heroId];
      return copy;
    });

    try {
      await api.delete(
        `/user-heroes/${userId}/hero/${heroId}`
      );
    } catch (err) {
      console.error('Помилка видалення героя:', err);

      setUserHeroes((prev) => ({
        ...prev,
        [heroId]: previousLevel
      }));
    }
  };

  // =========================================================
  // ЗАВАНТАЖЕННЯ
  // =========================================================

  if (loading) {
    return (
      <div className="
        p-4
        sm:p-6
        text-center
        text-slate-400
      ">
        Завантаження ростера...
      </div>
    );
  }

  // =========================================================
  // ПОМИЛКА
  // =========================================================

  if (error) {
    return (
      <div className="
        p-4
        sm:p-6

        text-center
        text-sm
        sm:text-base

        text-red-400

        bg-red-500/10

        border
        border-red-500/20

        rounded-xl
      ">
        {error}
      </div>
    );
  }

  // =========================================================
  // RARITY STYLES
  // =========================================================

  const rarityStyles = {
    Common: {
      border: 'border-gray-400',
      glow: 'shadow-gray-500/30',
      bg: 'from-gray-700 via-gray-900 to-black',
      text: 'text-gray-300'
    },

    Uncommon: {
      border: 'border-green-400',
      glow: 'shadow-green-500/40',
      bg: 'from-green-900/60 via-gray-900 to-black',
      text: 'text-green-300'
    },

    Rare: {
      border: 'border-blue-400',
      glow: 'shadow-blue-500/50',
      bg: 'from-blue-900/60 via-gray-900 to-black',
      text: 'text-blue-300'
    },

    Epic: {
      border: 'border-purple-400',
      glow: 'shadow-purple-500/50',
      bg: 'from-purple-900/60 via-gray-900 to-black',
      text: 'text-purple-300'
    },

    Legendary: {
      border: 'border-yellow-400',
      glow: 'shadow-yellow-500/60',
      bg: 'from-yellow-900/60 via-gray-900 to-black',
      text: 'text-yellow-300'
    }
  };

  // =========================================================
  // ФРАКЦІЇ У ПОТРІБНОМУ ПОРЯДКУ
  // =========================================================

  const factionOrder = [
    'Watchguard',
    'The North Throne',
    'Nightmare Council',
    'Cursed Cult',
    'Infernal Blast',
    'Star Piercers',
    'Esoteria Order',
    'Chaos Dominion',
    'Supreme Arbiters',
    'Grey Blades',
    'The Unnamable',
    'Faction',
  ];

  // =========================================================
  // ПОРЯДОК RARITY
  // =========================================================

  const raritySortOrder = {
    Legendary: 0,
    Epic: 1,
    Rare: 2,
    Uncommon: 3,
    Common: 4
  };
  // =========================================================
  // ФІЛЬТРАЦІЯ
  // =========================================================

  const filteredHeroes = heroes.filter((hero) => {
    const matchesSearch =
      !search ||
      hero.name
        ?.toLowerCase()
        .includes(search.toLowerCase());

    const matchesFaction =
      selectedFaction === 'ALL' ||
      hero.factions?.some(
        (faction) =>
          getBaseFaction(faction) === selectedFaction
      );

    const matchesRarity =
      selectedRarity === 'ALL' ||
      hero.rarity === selectedRarity;

    return (
      matchesSearch &&
      matchesFaction &&
      matchesRarity
    );
  });

  // =========================================================
  // СОРТУВАННЯ ГЕРОЇВ
  // =========================================================

  const sortHeroes = (heroesToSort) => {
    return [...heroesToSort].sort((a, b) => {
      const rarityA =
        raritySortOrder[a.rarity] ?? 999;

      const rarityB =
        raritySortOrder[b.rarity] ?? 999;

      if (rarityA !== rarityB) {
        return rarityA - rarityB;
      }

      return (a.name || '').localeCompare(
        b.name || ''
      );
    });
  };

  // =========================================================
  // СТВОРЕННЯ ГРУП ФРАКЦІЙ
  // =========================================================

  const factionGroups = factionOrder
    .filter((factionName) => factionName !== 'Faction')
    .map((factionName) => {
      const factionHeroes = filteredHeroes.filter(
        (hero) =>
          heroBelongsToFaction(
            hero,
            factionName
          )
      );

      const lords = factionHeroes.filter(
        (hero) =>
          isHeroLordForFaction(
            hero,
            factionName
          )
      );

      const normalHeroes = factionHeroes.filter(
        (hero) =>
          !isHeroLordForFaction(
            hero,
            factionName
          )
      );

      return {
        faction: factionName,
        lords: sortHeroes(lords),
        heroes: sortHeroes(normalHeroes)
      };
    });

  // =========================================================
  // НЕВІДОМІ ФРАКЦІЇ
  // =========================================================

  const knownFactionNames = new Set(
    factionOrder.filter(
      (factionName) => factionName !== 'Faction'
    )
  );

  const allBaseFactions = [
    ...new Set(
      filteredHeroes.flatMap((hero) => {
        if (!Array.isArray(hero.factions)) {
          return [];
        }

        return hero.factions
          .filter(Boolean)
          .map(getBaseFaction)
          .filter(Boolean);
      })
    )
  ];

  const unknownFactionNames = allBaseFactions
    .filter(
      (faction) =>
        !knownFactionNames.has(faction) &&
        faction !== 'Faction'
    )
    .sort((a, b) =>
      a.localeCompare(b)
    );

  unknownFactionNames.forEach((factionName) => {
    const factionHeroes = filteredHeroes.filter(
      (hero) =>
        heroBelongsToFaction(
          hero,
          factionName
        )
    );

    const lords = factionHeroes.filter(
      (hero) =>
        isHeroLordForFaction(
          hero,
          factionName
        )
    );

    const normalHeroes = factionHeroes.filter(
      (hero) =>
        !isHeroLordForFaction(
          hero,
          factionName
        )
    );

    factionGroups.push({
      faction: factionName,
      lords: sortHeroes(lords),
      heroes: sortHeroes(normalHeroes)
    });
  });

  // =========================================================
  // БЕЗ ФРАКЦІЇ
  // =========================================================

  const factionlessHeroes = sortHeroes(
    filteredHeroes.filter((hero) => {
      if (
        !Array.isArray(hero.factions) ||
        hero.factions.length === 0
      ) {
        return true;
      }

      const baseFactions = hero.factions
        .filter(Boolean)
        .map(getBaseFaction)
        .filter(Boolean);

      return (
        baseFactions.length === 0 ||
        baseFactions.every(
          (faction) => faction === 'Faction'
        )
      );
    })
  );
  // =========================================================
  // АДАПТИВНА GRID КАРТОК
  // =========================================================

  const heroGridClass = `
    grid

    grid-cols-2
    sm:grid-cols-4
    md:grid-cols-5
    lg:grid-cols-6
    xl:grid-cols-7

    gap-2
    sm:gap-3
  `;

  // =========================================================
  // КАРТКА ГЕРОЯ
  // =========================================================

  const renderHeroCard = (hero) => {
    const awakening = userHeroes[hero.id];
    const isActive = awakening !== undefined;

    // =======================================================
    // RARITY
    // =======================================================

    const rarity =
      rarityStyles[hero.rarity] || {
        border: 'border-gray-600',
        glow: 'shadow-gray-700/20',
        bg: 'from-gray-800 via-gray-950 to-black',
        text: 'text-gray-500'
      };

    // =======================================================
    // FACTIONS
    // =======================================================

    const heroFactions = Array.isArray(hero.factions)
      ? hero.factions.filter(Boolean)
      : [];

    const factionImages = heroFactions.map((faction) => {
      const lowerName =
        faction.trim().toLowerCase();

      const isLord =
        lowerName.endsWith(' lord');

      let fileName =
        factionToFileName(faction);

      // Спеціальна назва файлу
      // для Supreme Arbiters Lord
      if (isLord) {
        if (
          lowerName.includes(
            'supreme arbiter'
          )
        ) {
          fileName =
            'supreme_arbiter_lord';
        }
      }

      return {
        name: faction,
        isLord,
        src: isLord
          ? `/images/factions/lords/${fileName}.png`
          : `/images/factions/${fileName}.png`
      };
    });

    // =======================================================
    // CLASS
    // =======================================================

    const classFileName =
      hero.classIconSlug
        ? hero.classIconSlug.charAt(0).toUpperCase() +
          hero.classIconSlug.slice(1)
        : null;

    const classImage =
      classFileName
        ? `/images/classes/${classFileName}.webp`
        : null;

    // =======================================================
    // CARD
    // =======================================================

    return (
      <div
        key={hero.id}
        onClick={() =>
          handleLeftClick(hero.id)
        }
        onContextMenu={(e) =>
          handleRightClick(hero.id, e)
        }
        className={`
          relative
          cursor-pointer
          select-none

          rounded-lg
          overflow-hidden

          border
          sm:border-2

          ${rarity.border}

          bg-gradient-to-b
          ${rarity.bg}

          shadow-lg
          ${rarity.glow}

          transition-all
          duration-200

          md:hover:scale-105
          md:hover:brightness-110

          ${
            isActive
              ? 'opacity-100'
              : 'opacity-40 md:hover:opacity-70'
          }
        `}
        title="ЛКМ: пробудження | ПКМ: видалити"
      >
        <div className="
          relative
          aspect-[3/4]
          w-full
          overflow-hidden
        ">

          {/* ================================================= */}
          {/* HERO IMAGE */}
          {/* ================================================= */}

          {hero.imageSlug ? (
            <img
              src={`/images/heroes/${hero.imageSlug}.png`}
              alt={hero.name}
              className="
                absolute
                inset-0

                w-full
                h-full

                object-cover

                scale-75
              "
              onError={(e) => {
                e.currentTarget.style.display =
                  'none';
              }}
            />
          ) : (
            <div className="
              absolute
              inset-0

              flex
              items-center
              justify-center

              bg-gray-800

              text-[10px]
              sm:text-xs

              text-gray-400
            ">
              Немає фото
            </div>
          )}

          {/* ================================================= */}
          {/* ЗАТЕМНЕННЯ */}
          {/* ================================================= */}

          <div className="
            absolute
            inset-0

            bg-gradient-to-t
            from-black
            via-transparent
            to-black/20

            pointer-events-none
          " />

          {/* ================================================= */}
          {/* FACTIONS — ЛІВИЙ ВЕРХ */}
          {/* ================================================= */}

          {factionImages.length > 0 && (
            <div className="
              absolute

              top-0.5
              left-0

              z-20

              flex
              flex-col
              gap-0.5

              max-w-[28%]
            ">
              {factionImages.map((faction) => (
                <div
                  key={faction.name}
                  className="
                    w-8
                    h-8

                    sm:w-11
                    sm:h-11

                    md:w-15
                    md:h-15

                    rounded-full

                    p-0.5
                    sm:p-1
                    md:p-1.5

                    shadow-lg
                  "
                >
                  <img
                    src={faction.src}
                    alt={faction.name}
                    className="
                      w-full
                      h-full

                      object-contain
                    "
                    onError={(e) => {
                      console.warn(
                        'Не знайдено іконку фракції:',
                        faction.src
                      );

                      e.currentTarget
                        .parentElement
                        .style
                        .display = 'none';
                    }}
                  />
                </div>
              ))}
            </div>
          )}

          {/* ================================================= */}
          {/* CLASS — ПРАВИЙ ВЕРХ */}
          {/* ================================================= */}

          {classImage && (
            <div className="
              absolute

              top-0.5
              right-0.5

              z-20

              w-7
              h-7

              sm:w-9
              sm:h-9

              md:w-12
              md:h-12

              rounded-full

              p-0.5
              sm:p-1
              md:p-1.5

              shadow-lg
            ">
              <img
                src={classImage}
                alt={hero.className}
                className="
                  w-full
                  h-full

                  object-contain
                "
                onError={(e) => {
                  console.warn(
                    'Не знайдено іконку класу:',
                    classImage
                  );

                  e.currentTarget
                    .parentElement
                    .style
                    .display = 'none';
                }}
              />
            </div>
          )}

          {/* ================================================= */}
          {/* RARITY */}
          {/* ================================================= */}

          <div className="
            absolute

            top-1
            left-1/2

            -translate-x-1/2

            z-20

            px-1
            sm:px-2

            py-0.5

            rounded

            bg-black/70

            border
            border-yellow-400/50

            text-[7px]
            sm:text-[9px]

            font-bold
            uppercase

            tracking-wider

            whitespace-nowrap
          ">
            <span className={rarity.text}>
              {hero.rarity || 'UNKNOWN'}
            </span>
          </div>

          {/* ================================================= */}
          {/* HERO NAME */}
          {/* ================================================= */}

          <div className="
            absolute

            bottom-0
            left-0
            right-0

            z-20

            px-1
            pb-1

            pt-6
            sm:pt-8

            text-center

            bg-gradient-to-t
            from-black
            via-black/75
            to-transparent
          ">
            <div className="
              text-[10px]
              sm:text-xs

              font-bold
              text-white

              leading-tight

              line-clamp-2

              drop-shadow-[0_1px_3px_rgba(0,0,0,1)]
            ">
              {hero.name}
            </div>
          </div>

          {/* ================================================= */}
          {/* AWAKENING */}
          {/* ================================================= */}

          {isActive && (
            <div className="
              absolute

              bottom-1
              right-1

              z-30

              min-w-5
              h-5

              sm:min-w-6
              sm:h-6

              md:min-w-7
              md:h-7

              px-1
              sm:px-1.5

              flex
              items-center
              justify-center

              rounded-full

              bg-yellow-500

              border
              sm:border-2

              border-yellow-200

              text-black

              text-[9px]
              sm:text-[10px]
              md:text-xs

              font-black

              shadow-lg
            ">
              A{awakening}
            </div>
          )}

        </div>
      </div>
    );
  };

  // =========================================================
  // ПЕРЕВІРКА ЧИ Є ХОЧ ЯКІСЬ РЕЗУЛЬТАТИ
  // =========================================================

  const hasResults =
    factionGroups.some(
      (group) =>
        group.lords.length > 0 ||
        group.heroes.length > 0
    ) ||
    factionlessHeroes.length > 0;

  // =========================================================
  // ОСНОВНИЙ ІНТЕРФЕЙС
  // =========================================================

  return (
    <div className="w-full min-w-0">

      {/* =================================================== */}
      {/* FILTERS */}
      {/* =================================================== */}

      <div className="
        mb-4
        sm:mb-5

        p-3
        sm:p-4

        rounded-xl

        bg-slate-900/70
        border
        border-slate-700
      ">

        <div className="
          grid
          grid-cols-1
          md:grid-cols-3

          gap-2
          sm:gap-3
        ">

          {/* ================================================= */}
          {/* SEARCH */}
          {/* ================================================= */}

          <input
            type="text"
            value={search}
            onChange={(e) =>
              setSearch(e.target.value)
            }
            placeholder="Пошук героя..."
            className="
              w-full

              px-3
              py-2

              rounded-lg

              bg-slate-800
              border
              border-slate-600

              text-white
              text-sm

              placeholder:text-slate-500

              outline-none

              focus:border-blue-500
              focus:ring-1
              focus:ring-blue-500
            "
          />

          {/* ================================================= */}
          {/* FACTION */}
          {/* ================================================= */}

          <select
            value={selectedFaction}
            onChange={(e) =>
              setSelectedFaction(e.target.value)
            }
            className="
              w-full

              px-3
              py-2

              rounded-lg

              bg-slate-800
              border
              border-slate-600

              text-white
              text-sm

              outline-none

              focus:border-blue-500

              truncate
            "
          >
            <option value="ALL">
              Всі фракції
            </option>

            {[
              ...new Set(
                heroes.flatMap((hero) =>
                  Array.isArray(hero.factions)
                    ? hero.factions
                        .filter(Boolean)
                        .map(getBaseFaction)
                        .filter(Boolean)
                        .filter(
                          (faction) =>
                            faction !== 'Faction'
                        )
                    : []
                )
              )
            ]
              .sort((a, b) =>
                a.localeCompare(b)
              )
              .map((faction) => (
                <option
                  key={faction}
                  value={faction}
                >
                  {faction}
                </option>
              ))}
          </select>

          {/* ================================================= */}
          {/* RARITY */}
          {/* ================================================= */}

          <select
            value={selectedRarity}
            onChange={(e) =>
              setSelectedRarity(e.target.value)
            }
            className="
              w-full

              px-3
              py-2

              rounded-lg

              bg-slate-800
              border
              border-slate-600

              text-white
              text-sm

              outline-none

              focus:border-blue-500
            "
          >
            <option value="ALL">
              Всі rarity
            </option>

            {[
              'Common',
              'Uncommon',
              'Rare',
              'Epic',
              'Legendary'
            ]
              .filter((rarity) =>
                heroes.some(
                  (hero) =>
                    hero.rarity === rarity
                )
              )
              .map((rarity) => (
                <option
                  key={rarity}
                  value={rarity}
                >
                  {rarity}
                </option>
              ))}
          </select>

        </div>

        {/* =================================================== */}
        {/* FILTER INFO */}
        {/* =================================================== */}

        <div className="
          mt-3

          flex
          flex-col
          gap-2

          sm:flex-row
          sm:items-center
          sm:justify-between

          text-xs
          text-slate-400
        ">

          <span>
            Показано: {filteredHeroes.length} / {heroes.length}
          </span>

          <button
            type="button"
            onClick={() => {
              setSearch('');
              setSelectedFaction('ALL');
              setSelectedRarity('ALL');
            }}
            className="
              w-full
              sm:w-auto

              px-3
              py-1.5

              rounded-md

              bg-slate-800
              hover:bg-slate-700

              border
              border-slate-600

              text-slate-300
              hover:text-white

              transition
            "
          >
            Скинути
          </button>

        </div>

      </div>

      {/* =================================================== */}
      {/* HERO GROUPS */}
      {/* =================================================== */}

      {hasResults && (
        <div className="
          space-y-6
          sm:space-y-10
        ">

          {factionGroups.map((group) => {
            if (
              group.lords.length === 0 &&
              group.heroes.length === 0
            ) {
              return null;
            }

            return (
              <div
                key={group.faction}
                className="min-w-0"
              >

                {/* ========================================= */}
                {/* НАЗВА ФРАКЦІЇ */}
                {/* ========================================= */}

                <div className="
                  mb-2

                  text-xs
                  sm:text-sm

                  font-bold
                  uppercase

                  tracking-wide
                  sm:tracking-wider

                  text-slate-400
                ">
                  {group.faction}
                </div>

                {/* ========================================= */}
                {/* LORDS */}
                {/* ========================================= */}

                {group.lords.length > 0 && (
                  <div className={heroGridClass}>
                    {group.lords.map(
                      renderHeroCard
                    )}
                  </div>
                )}

                {/* ========================================= */}
                {/* NORMAL HEROES */}
                {/* ========================================= */}

                {group.heroes.length > 0 && (
                  <div
                    className={`
                      ${heroGridClass}

                      ${
                        group.lords.length > 0
                          ? 'mt-3 sm:mt-4'
                          : ''
                      }
                    `}
                  >
                    {group.heroes.map(
                      renderHeroCard
                    )}
                  </div>
                )}

              </div>
            );
          })}

          {/* ================================================= */}
          {/* БЕЗ ФРАКЦІЇ */}
          {/* ================================================= */}

          {factionlessHeroes.length > 0 && (
            <div>

              <div className="
                mb-2

                text-xs
                sm:text-sm

                font-bold
                uppercase

                tracking-wide
                sm:tracking-wider

                text-slate-500
              ">
                Без фракції
              </div>

              <div className={heroGridClass}>
                {factionlessHeroes.map(
                  renderHeroCard
                )}
              </div>

            </div>
          )}

        </div>
      )}

      {/* =================================================== */}
      {/* EMPTY RESULT */}
      {/* =================================================== */}

      {!hasResults && (
        <div className="
          mt-4
          sm:mt-6

          p-6
          sm:p-8

          text-center

          rounded-xl

          bg-slate-900/70
          border
          border-slate-700

          text-sm
          sm:text-base

          text-slate-400
        ">
          Героїв за заданими фільтрами не знайдено.
        </div>
      )}

    </div>
  );
};

export default UserRoster;