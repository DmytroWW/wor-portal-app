import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import api from '../../api/axios';

const MAP_TYPES = [
  { value: 'FORT', label: 'Fort' },
  { value: 'TOWER', label: 'Tower' },
];

const RARITY_RING = {
  Common: 'ring-gray-400',
  Uncommon: 'ring-green-400',
  Rare: 'ring-blue-400',
  Epic: 'ring-purple-400',
  Legendary: 'ring-amber-400',
};

const SoldierImage = ({ soldier, className = '', fallbackClassName = '' }) => {
  const fallback = soldier?.name?.trim()?.charAt(0)?.toUpperCase() || 'S';

  return (
    <div className={`relative overflow-hidden bg-surface-overlay ${className}`}>
      {soldier?.imageSlug ? (
        <img
          src={`/images/demon-soldiers/${soldier.imageSlug}.webp`}
          alt={soldier.name || 'Гвг солдат'}
          draggable="false"
          className="h-full w-full select-none object-cover"
          onError={(event) => {
            event.currentTarget.style.display = 'none';
            event.currentTarget.nextElementSibling?.classList.remove('hidden');
          }}
        />
      ) : null}
      <div
        data-image-fallback
        className={`${soldier?.imageSlug ? 'hidden ' : ''}absolute inset-0 flex items-center justify-center font-black text-foreground-primary ${fallbackClassName}`}
        aria-hidden="true"
      >
        {fallback}
      </div>
    </div>
  );
};

const MAP_DIMENSIONS = {
  FORT: { width: 1920, height: 1080 },
  TOWER: { width: 1920, height: 1080 },
};

// Напрямки, кути повороту стрілки за годинниковою стрілкою та її позиція
// на краю клітинки (сама іконка героя при цьому ніколи не обертається).
const ATTACK_DIRECTIONS = [
  {
    value: 'UP',
    arrow: '↑',
    angle: 0,
    position: 'left-1/2 top-0.5 -translate-x-1/2',
  },
  {
    value: 'RIGHT',
    arrow: '↑',
    angle: 90,
    position: 'right-0.5 top-1/2 -translate-y-1/2',
  },
  {
    value: 'DOWN',
    arrow: '↑',
    angle: 180,
    position: 'left-1/2 bottom-0.5 -translate-x-1/2',
  },
  {
    value: 'LEFT',
    arrow: '↑',
    angle: 270,
    position: 'left-0.5 top-1/2 -translate-y-1/2',
  },
];

const getDirection = (direction) =>
  ATTACK_DIRECTIONS.find((item) => item.value === direction) ||
  ATTACK_DIRECTIONS[2];

const errorMessage = (error) =>
  error?.response?.data?.message ||
  error?.response?.data?.error ||
  error?.message ||
  'Сталася помилка запиту.';

const inputClass =
  'w-full rounded-lg border border-surface-border bg-surface-sunken px-3 py-2 text-sm text-foreground-primary outline-none transition-colors placeholder:text-foreground-muted/70 focus:border-brand-accent disabled:cursor-not-allowed disabled:opacity-50';

const buttonSecondaryClass =
  'inline-flex items-center justify-center gap-1 rounded-lg border border-surface-border bg-surface-sunken px-3 py-2 text-xs font-semibold text-foreground-secondary transition-colors hover:border-brand-accent/50 hover:bg-surface-raised hover:text-foreground-primary focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-accent disabled:cursor-not-allowed disabled:opacity-50';

const buttonPrimaryClass =
  'inline-flex items-center justify-center gap-1 rounded-lg bg-brand-accent px-3 py-2 text-xs font-bold text-foreground-onAccent shadow-brand-accent transition-colors hover:bg-brand-accent-hover focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-accent disabled:cursor-not-allowed disabled:opacity-50';

export default function GvgPage() {
  const [mapType, setMapType] = useState('TOWER');
  const [map, setMap] = useState(null);
  const [tiles, setTiles] = useState([]);
  const [heroes, setHeroes] = useState([]);

  const [presets, setPresets] = useState([]);
  const [openedPreset, setOpenedPreset] = useState(null);

  const [selectedHeroId, setSelectedHeroId] = useState(null);
  const [heroPlacements, setHeroPlacements] = useState({});

  const [attackCode, setAttackCode] = useState('');
  const [attackName, setAttackName] = useState('');
  const [description, setDescription] = useState('');
  const [searchCode, setSearchCode] = useState('');

  // Гвг солдати, призначені пресету атаки.
  const [demonSoldiers, setDemonSoldiers] = useState([]);
  const [presetSoldiers, setPresetSoldiers] = useState([]);
  const [selectedDemonSoldierId, setSelectedDemonSoldierId] = useState('');
  const [demonSoldierQuantity, setDemonSoldierQuantity] = useState(1);
  const [isDemonSoldierDropdownOpen, setIsDemonSoldierDropdownOpen] = useState(false);
  const [demonSoldierSearchQuery, setDemonSoldierSearchQuery] = useState('');

  const [classFilter, setClassFilter] = useState('ALL');
  const [heroSearchQuery, setHeroSearchQuery] = useState('');
  const [sortBy, setSortBy] = useState('NAME');

  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);

  const [error, setError] = useState('');
  const [notice, setNotice] = useState('');

  const [calibration, setCalibration] = useState({
    FORT: {
      offsetX: 86,
      offsetY: -38,
      scale: 1.0,
      widthPct: 74,
      heightPct: 100,
    },
    TOWER: {
      offsetX: 75,
      offsetY: -30,
      scale: 0.92,
      widthPct: 76,
      heightPct: 100,
    },
  });

  const currentCalib = calibration[mapType] || {
    offsetX: 0,
    offsetY: 0,
    scale: 1,
    widthPct: 100,
    heightPct: 100,
  };

  const updateCalib = (field, value) => {
    setCalibration((prev) => ({
      ...prev,
      [mapType]: {
        ...prev[mapType],
        [field]: value,
      },
    }));
  };

  const [viewportWidth, setViewportWidth] = useState(() =>
    typeof window !== 'undefined' ? window.innerWidth : 1280
  );

  useEffect(() => {
    const handleResize = () => setViewportWidth(window.innerWidth);

    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);

  const heroListRef = useRef(null);
  const demonSoldierDropdownRef = useRef(null);

  useEffect(() => {
    if (!isDemonSoldierDropdownOpen) return undefined;

    const handlePointerDown = (event) => {
      if (!demonSoldierDropdownRef.current?.contains(event.target)) {
        setIsDemonSoldierDropdownOpen(false);
      }
    };

    document.addEventListener('pointerdown', handlePointerDown);
    return () => document.removeEventListener('pointerdown', handlePointerDown);
  }, [isDemonSoldierDropdownOpen]);

  const loadMap = useCallback(async () => {
    setLoading(true);
    setError('');
    setNotice('');
    setOpenedPreset(null);

    try {
      const mapResponse = await api.get(
        `/gvg/maps/active?type=${mapType}`
      );

      const activeMap = mapResponse.data;
      setMap(activeMap);

      const tilesResponse = await api.get(
        `/gvg/maps/${activeMap.id}/tiles`
      );

      setTiles(
        Array.isArray(tilesResponse.data) ? tilesResponse.data : []
      );

      setHeroPlacements({});
      setSelectedHeroId(null);
    } catch (err) {
      setMap(null);
      setTiles([]);
      setHeroPlacements({});
      setSelectedHeroId(null);
      setError(errorMessage(err));
    } finally {
      setLoading(false);
    }
  }, [mapType]);

  const loadHeroes = useCallback(async () => {
    try {
      const response = await api.get('/heroes');
      setHeroes(Array.isArray(response.data) ? response.data : []);
    } catch (err) {
      setError(errorMessage(err));
    }
  }, []);

  const loadPresets = useCallback(async () => {
    try {
      const response = await api.get('/gvg/presets');
      setPresets(Array.isArray(response.data) ? response.data : []);
    } catch (err) {
      setError(errorMessage(err));
    }
  }, []);

  const loadDemonSoldiers = useCallback(async () => {
    try {
      const response = await api.get('/demon-soldiers');
      setDemonSoldiers(Array.isArray(response.data) ? response.data : []);
    } catch (err) {
      setError(errorMessage(err));
    }
  }, []);

  useEffect(() => {
    loadHeroes();
    loadPresets();
    loadDemonSoldiers();
  }, [loadHeroes, loadPresets, loadDemonSoldiers]);

  useEffect(() => {
    loadMap();
  }, [loadMap]);

  const tileLookup = useMemo(() => {
    const lookup = new Map();

    tiles.forEach((tile) => {
      lookup.set(`${tile.x},${tile.y}`, tile);
    });

    return lookup;
  }, [tiles]);

  const occupiedTileIds = useMemo(
    () =>
      new Set(
        Object.values(heroPlacements)
          .map((placement) => placement.tileId)
          .filter(Boolean)
      ),
    [heroPlacements]
  );

  const selectHero = (hero) => {
    setError('');
    setNotice('');

    setSelectedHeroId((current) =>
      current === hero.id ? null : hero.id
    );
  };

  const placeHero = (tile) => {
    if (!selectedHeroId) {
      setError('Спочатку вибери героя зі списку внизу.');
      return;
    }

    if (!tile || tile.tileType === 'EMPTY') return;

    const existingPlacement = heroPlacements[selectedHeroId];

    if (
      occupiedTileIds.has(tile.id) &&
      existingPlacement?.tileId !== tile.id
    ) {
      setError('Ця клітинка вже зайнята іншим героєм.');
      return;
    }

    setHeroPlacements((current) => ({
      ...current,
      [selectedHeroId]: {
        heroId: selectedHeroId,
        tileId: tile.id,
        x: tile.x,
        y: tile.y,
        attackDirection:
          current[selectedHeroId]?.attackDirection || 'DOWN',
      },
    }));

    setError('');
    setNotice(`Героя розміщено на (${tile.x}, ${tile.y}).`);
  };

  // Повертає тільки стрілку напрямку героя за годинниковою стрілкою на 90°.
  // Іконка героя при цьому залишається нерухомою.
  const rotateHero = (heroId) => {
    setHeroPlacements((current) => {
      const placement = current[heroId];

      if (!placement) return current;

      const currentDirection = getDirection(
        placement.attackDirection
      );

      const currentIndex = ATTACK_DIRECTIONS.findIndex(
        (direction) => direction.value === currentDirection.value
      );

      const nextDirection =
        ATTACK_DIRECTIONS[
          (currentIndex + 1) % ATTACK_DIRECTIONS.length
        ];

      return {
        ...current,
        [heroId]: {
          ...placement,
          attackDirection: nextDirection.value,
        },
      };
    });

    setError('');
    setNotice('Стрілку напрямку повернуто на 90° за годинниковою стрілкою.');
  };

  const removeHeroFromMap = (heroId) => {
    setHeroPlacements((current) => {
      const copy = { ...current };
      delete copy[heroId];
      return copy;
    });

    if (selectedHeroId === heroId) {
      setSelectedHeroId(null);
    }

    setError('');
    setNotice('Героя прибрано з мапи.');
  };

  const addPresetSoldier = () => {
    setError('');
    setNotice('');

    if (!selectedDemonSoldierId) {
      setError('Вибери гвг солдата зі списку.');
      return;
    }

    const soldier = demonSoldiers.find(
      (item) => String(item.id) === String(selectedDemonSoldierId)
    );

    if (!soldier) {
      setError('Такого гвг солдата не знайдено.');
      return;
    }

    const quantity = Math.max(1, Number(demonSoldierQuantity) || 1);

    setPresetSoldiers((current) => {
      const existingIndex = current.findIndex(
        (item) => item.demonSoldierId === soldier.id
      );

      if (existingIndex >= 0) {
        const updated = [...current];
        updated[existingIndex] = {
          ...updated[existingIndex],
          quantity,
        };
        return updated;
      }

      return [
        ...current,
        { demonSoldierId: soldier.id, quantity, demonSoldier: soldier },
      ];
    });

    setSelectedDemonSoldierId('');
    setDemonSoldierQuantity(1);
    setDemonSoldierSearchQuery('');
    setIsDemonSoldierDropdownOpen(false);
    setNotice(`Гвг солдата «${soldier.name}» додано до пресету.`);
  };

  const removePresetSoldier = (demonSoldierId) => {
    setPresetSoldiers((current) =>
      current.filter((item) => item.demonSoldierId !== demonSoldierId)
    );
  };

  const resetRecord = () => {
    setHeroPlacements({});
    setSelectedHeroId(null);
    setAttackCode('');
    setAttackName('');
    setDescription('');
    setSearchCode('');
    setPresetSoldiers([]);
    setSelectedDemonSoldierId('');
    setDemonSoldierQuantity(1);
    setDemonSoldierSearchQuery('');
    setIsDemonSoldierDropdownOpen(false);
    setOpenedPreset(null);
    setError('');
    setNotice('Запис скинуто.');
  };

  const clearHeroFilters = () => {
    setHeroSearchQuery('');
    setClassFilter('ALL');
  };

  const savePreset = async () => {
    setError('');
    setNotice('');

    if (!map) {
      setError('Активну мапу не завантажено.');
      return;
    }

    if (!attackCode.trim()) {
      setError('Введи код пресету.');
      return;
    }

    if (!attackName.trim()) {
      setError('Введи назву атаки.');
      return;
    }

    const placements = Object.values(heroPlacements);

    if (placements.length === 0) {
      setError('Постав хоча б одного героя.');
      return;
    }

    setSaving(true);

    try {
      const presetResponse = await api.post('/gvg/presets', {
        mapId: map.id,
        presetCode: attackCode.trim(),
        name: attackName.trim(),
        description: description.trim() || null,
      });

      const preset = presetResponse.data;

      for (const placement of placements) {
        await api.post(`/gvg/presets/${preset.id}/heroes`, {
          heroId: placement.heroId,
          tileId: placement.tileId,
          attackDirection: placement.attackDirection,
        });
      }

      for (const soldier of presetSoldiers) {
        await api.post(`/gvg/presets/${preset.id}/demon-soldiers`, {
          demonSoldierId: soldier.demonSoldierId,
          quantity: soldier.quantity,
        });
      }

      setNotice(`Журнал атаки «${preset.presetCode}» записано.`);
      setOpenedPreset(null);

      await loadPresets();
    } catch (err) {
      setError(errorMessage(err));
    } finally {
      setSaving(false);
    }
  };

  const openPreset = async (presetId) => {
    setError('');
    setNotice('');

    try {
      const response = await api.get(
        `/gvg/presets/${presetId}/details`
      );

      const details = response.data;
      setOpenedPreset(details);

      const restoredPlacements = {};

      for (const hero of details.heroes || []) {
        restoredPlacements[hero.heroId] = {
          heroId: hero.heroId,
          tileId: hero.tileId,
          x: hero.x,
          y: hero.y,
          attackDirection: hero.attackDirection || 'DOWN',
        };
      }

      setHeroPlacements(restoredPlacements);
      setSelectedHeroId(null);
      setAttackCode(details.preset?.presetCode || '');
      setAttackName(details.preset?.name || '');
      setDescription(details.preset?.description || '');

      // Гвг солдати пресету тягнуться окремим запитом, щоб не залежати
      // від структури відповіді /details.
      try {
        const soldiersResponse = await api.get(
          `/gvg/presets/${presetId}/demon-soldiers`
        );

        const assigned = Array.isArray(soldiersResponse.data)
          ? soldiersResponse.data
          : [];

        setPresetSoldiers(
          assigned.map((item) => {
            const demonSoldierId =
              item.demonSoldierId ?? item.demonSoldier?.id;

            return {
              demonSoldierId,
              quantity: item.quantity ?? 1,
              demonSoldier:
                item.demonSoldier ||
                demonSoldiers.find(
                  (soldier) => soldier.id === demonSoldierId
                ) || {
                  id: demonSoldierId,
                  name: item.demonSoldierName,
                  rarity: item.rarity,
                  level: item.level,
                },
            };
          })
        );
      } catch {
        setPresetSoldiers([]);
      }

      setNotice(
        `Завантажено атаку «${details.preset?.presetCode}».`
      );
    } catch (err) {
      setError(errorMessage(err));
    }
  };

  const findPresetByCode = () => {
    const normalized = searchCode.trim().toLowerCase();

    if (!normalized) {
      setError('Введи код оборони.');
      return;
    }

    const found = presets.find(
      (preset) => preset.presetCode?.toLowerCase() === normalized
    );

    if (!found) {
      setError('Атаку не знайдено.');
      return;
    }

    openPreset(found.id);
  };

  const placedHeroes = useMemo(
    () =>
      Object.values(heroPlacements)
        .map((placement) => ({
          ...placement,
          hero: heroes.find((hero) => hero.id === placement.heroId),
        }))
        .filter((item) => item.hero),
    [heroPlacements, heroes]
  );

  const placedHeroesByTile = useMemo(
    () =>
      new Map(
        placedHeroes.map((placement) => [
          placement.tileId,
          placement,
        ])
      ),
    [placedHeroes]
  );

  const heroClasses = useMemo(
    () =>
      [...new Set(heroes.map((hero) => hero.className).filter(Boolean))]
        .sort(),
    [heroes]
  );

  const visibleHeroes = useMemo(() => {
    let list = heroes;

    if (classFilter !== 'ALL') {
      list = list.filter((hero) => hero.className === classFilter);
    }

    if (heroSearchQuery.trim()) {
      const query = heroSearchQuery.trim().toLowerCase();

      list = list.filter((hero) =>
        hero.name?.toLowerCase().includes(query)
      );
    }

    return [...list].sort((a, b) => {
      if (sortBy === 'CLASS') {
        return (
          (a.className || '').localeCompare(b.className || '') ||
          (a.name || '').localeCompare(b.name || '')
        );
      }

      return (a.name || '').localeCompare(b.name || '');
    });
  }, [heroes, classFilter, heroSearchQuery, sortBy]);

  const selectedDemonSoldier = useMemo(
    () =>
      demonSoldiers.find(
        (soldier) => String(soldier.id) === String(selectedDemonSoldierId)
      ) || null,
    [demonSoldiers, selectedDemonSoldierId]
  );

  const visibleDemonSoldiers = useMemo(() => {
    const query = demonSoldierSearchQuery.trim().toLowerCase();
    if (!query) return demonSoldiers;

    return demonSoldiers.filter((soldier) =>
      [soldier.name, soldier.rarity, soldier.faction]
        .filter(Boolean)
        .some((value) => String(value).toLowerCase().includes(query))
    );
  }, [demonSoldiers, demonSoldierSearchQuery]);

  const selectDemonSoldier = (soldier) => {
    setSelectedDemonSoldierId(String(soldier.id));
    setDemonSoldierSearchQuery('');
    setIsDemonSoldierDropdownOpen(false);
  };

  const scrollHeroList = (direction) => {
    heroListRef.current?.scrollBy({
      left: direction * 260,
      behavior: 'smooth',
    });
  };

  const copyConfigToClipboard = async () => {
    const configStr =
      `${mapType}: { width: ${viewportWidth}px, ` +
      `offsetX: ${currentCalib.offsetX}, ` +
      `offsetY: ${currentCalib.offsetY}, ` +
      `scale: ${currentCalib.scale}, ` +
      `widthPct: ${currentCalib.widthPct}, ` +
      `heightPct: ${currentCalib.heightPct} }`;

    try {
      await navigator.clipboard.writeText(configStr);
      setNotice(
        `Налаштування для ${mapType} (${viewportWidth}px) скопійовано!`
      );
    } catch {
      setError('Не вдалося скопіювати налаштування.');
    }
  };

  if (loading) {
    return (
      <div className="mx-auto max-w-7xl px-3 pt-1 md:px-0">
        <div className="rounded-2xl border border-surface-border bg-surface-raised p-6 text-center text-sm text-foreground-secondary shadow-surface">
          Завантаження GvG мапи…
        </div>
      </div>
    );
  }

  const currentDim = MAP_DIMENSIONS[mapType] || MAP_DIMENSIONS.FORT;

  return (
    <div className="mx-auto max-w-7xl space-y-3 px-3 pt-1 text-foreground-primary md:px-0">
      {!map ? (
        <div className="rounded-2xl border border-dashed border-surface-border bg-surface-raised p-6 text-center text-sm text-foreground-secondary">
          Для цього типу зараз немає активної GvG мапи.
        </div>
      ) : (
        <div className="overflow-hidden rounded-2xl border border-surface-border bg-surface-raised shadow-surface">
          <div className="grid gap-0 lg:grid-cols-[minmax(0,1fr)_320px]">
            {/* Мапа */}
            <section className="relative flex flex-col justify-center border-b border-surface-border bg-surface-base p-3 pb-4 pt-14 lg:border-b-0 lg:border-r">
              {/* Калібрування */}
              <div className="absolute right-3 top-14 z-40 w-52 space-y-2 rounded-xl border border-brand-accent/30 bg-surface-overlay/95 p-3 text-[10px] text-foreground-secondary shadow-surface backdrop-blur">
                <div className="flex items-center justify-between border-b border-surface-border pb-2">
                  <span className="font-bold uppercase tracking-wider text-brand-accent">
                    Підгонка ({mapType})
                  </span>
                  <span className="font-mono text-foreground-muted">
                    {viewportWidth}px
                  </span>
                </div>

                {[
                  {
                    field: 'offsetX',
                    label: 'Зсув X',
                    min: -150,
                    max: 150,
                    step: 1,
                    value: currentCalib.offsetX,
                    suffix: 'px',
                  },
                  {
                    field: 'offsetY',
                    label: 'Зсув Y',
                    min: -150,
                    max: 150,
                    step: 1,
                    value: currentCalib.offsetY,
                    suffix: 'px',
                  },
                  {
                    field: 'scale',
                    label: 'Масштаб',
                    min: 0.5,
                    max: 2,
                    step: 0.01,
                    value: currentCalib.scale,
                    suffix: 'x',
                  },
                  {
                    field: 'widthPct',
                    label: 'Ширина сітки',
                    min: 50,
                    max: 150,
                    step: 1,
                    value: currentCalib.widthPct,
                    suffix: '%',
                  },
                  {
                    field: 'heightPct',
                    label: 'Висота сітки',
                    min: 50,
                    max: 150,
                    step: 1,
                    value: currentCalib.heightPct,
                    suffix: '%',
                  },
                ].map((control) => (
                  <div key={control.field}>
                    <div className="mb-1 flex justify-between gap-2">
                      <label htmlFor={`calib-${control.field}`}>
                        {control.label}
                      </label>
                      <span className="font-mono text-brand-accent">
                        {control.value}
                        {control.suffix}
                      </span>
                    </div>

                    <input
                      id={`calib-${control.field}`}
                      type="range"
                      min={control.min}
                      max={control.max}
                      step={control.step}
                      value={control.value}
                      onChange={(event) =>
                        updateCalib(
                          control.field,
                          Number(event.target.value)
                        )
                      }
                      className="w-full cursor-pointer accent-brand-accent"
                    />
                  </div>
                ))}

                <button
                  type="button"
                  onClick={copyConfigToClipboard}
                  className={`${buttonPrimaryClass} w-full`}
                >
                  Скопіювати показники
                </button>
              </div>

              {/* Заголовок мапи */}
              <div className="absolute inset-x-0 top-0 z-30 flex items-start justify-between gap-3 bg-gradient-to-b from-surface-raised/95 to-transparent p-3">
                <div>
                  <h1 className="text-sm font-bold tracking-wide text-foreground-primary">
                    Enemy Defense Setup — {map.name}
                  </h1>
                  <p className="mt-0.5 text-[10px] text-foreground-muted">
                    Розстановка героїв на мапі
                  </p>
                </div>

                <span className="shrink-0 rounded-full border border-brand-success/30 bg-brand-success/10 px-2 py-1 text-[9px] font-bold uppercase tracking-wider text-brand-success-hover">
                  Активна мапа
                </span>
              </div>

              {/* Ігрове поле */}
              <div
                className="relative mx-auto my-auto flex w-full max-w-[1000px] items-center justify-center overflow-hidden rounded-xl border border-surface-border bg-surface-overlay shadow-surface"
                style={{
                  aspectRatio: `${currentDim.width} / ${currentDim.height}`,
                }}
              >
                <img
                  src={
                    mapType === 'FORT'
                      ? '/images/maps/fort-bg.png'
                      : '/images/maps/tower-bg.png'
                  }
                  alt={map.name}
                  className="pointer-events-none h-full w-full select-none object-contain"
                />

                <div
                  className="pointer-events-none absolute inset-8 flex items-center justify-center transition-transform duration-75"
                  style={{
                    transform:
                      `translate(${currentCalib.offsetX}px, ${currentCalib.offsetY}px) ` +
                      `scale(${currentCalib.scale})`,
                    transformOrigin: 'center center',
                    width: `${currentCalib.widthPct}%`,
                    height: `${currentCalib.heightPct}%`,
                  }}
                >
                  <div
                    className="pointer-events-auto grid h-full w-full"
                    style={{
                      gridTemplateColumns: `repeat(${map.width}, minmax(0, 1fr))`,
                      gridTemplateRows: `repeat(${map.height}, minmax(0, 1fr))`,
                      gap: '2px',
                    }}
                  >
                    {Array.from({ length: map.height }, (_, y) =>
                      Array.from({ length: map.width }, (_, x) => {
                        const tile = tileLookup.get(`${x},${y}`);

                        if (!tile || tile.tileType === 'EMPTY') {
                          return <div key={`${x}-${y}`} />;
                        }

                        const placedHero = placedHeroesByTile.get(tile.id);
                        const isOccupied = occupiedTileIds.has(tile.id);
                        const isAvailableTarget =
                          selectedHeroId && !isOccupied;

                        const direction = placedHero
                          ? getDirection(placedHero.attackDirection)
                          : null;

                        return (
                          <button
                            key={`${x}-${y}`}
                            type="button"
                            onClick={() => placeHero(tile)}
                            aria-label={
                              placedHero
                                ? `${placedHero.hero.name}, координати ${x}, ${y}. Напрямок: ${direction.value}. Клікни по зображенню для повороту стрілки.`
                                : `Клітинка ${x}, ${y}`
                            }
                            className={`relative flex h-full w-full items-center justify-center rounded-sm border transition-colors ${
                              placedHero
                                ? 'z-10 border-brand-danger bg-brand-danger/20 shadow-[0_0_10px_rgba(239,68,68,0.6)]'
                                : isAvailableTarget
                                  ? 'z-10 animate-pulse border-brand-success/80 bg-brand-success/20 shadow-[0_0_8px_rgba(16,185,129,0.4)]'
                                  : 'border-surface-border/70 bg-surface-overlay/20 hover:border-brand-accent/60 hover:bg-brand-accent/20'
                            }`}
                            title={`X: ${x}, Y: ${y} · ${tile.tileType}`}
                          >
                            {placedHero && (
                              <>
                                <span className="pointer-events-none absolute -inset-px rounded-sm border border-brand-danger" />

                                {/* Іконка героя лишається нерухомою — обертається лише стрілка напрямку. */}
                                <div
                                  role="button"
                                  tabIndex={0}
                                  aria-label={`Повернути стрілку напрямку героя ${placedHero.hero?.name || ''} за годинниковою стрілкою`}
                                  title={`Напрямок: ${direction.value}. Клікни, щоб повернути стрілку на 90°`}
                                  onClick={(event) => {
                                    event.preventDefault();
                                    event.stopPropagation();
                                    rotateHero(placedHero.heroId);
                                  }}
                                  onKeyDown={(event) => {
                                    if (
                                      event.key === 'Enter' ||
                                      event.key === ' '
                                    ) {
                                      event.preventDefault();
                                      event.stopPropagation();
                                      rotateHero(placedHero.heroId);
                                    }
                                  }}
                                  className="absolute inset-0.5 z-10 cursor-pointer rounded-sm focus-visible:outline-2 focus-visible:outline-offset-1 focus-visible:outline-brand-accent"
                                >
                                  {/* Статична іконка героя, без трансформацій */}
                                  <div className="h-full w-full overflow-hidden rounded-sm">
                                    {placedHero.hero?.imageSlug ? (
                                      <img
                                        src={`/images/heroes/${placedHero.hero.imageSlug}.png`}
                                        alt={placedHero.hero.name}
                                        draggable="false"
                                        className="pointer-events-none h-full w-full select-none object-cover"
                                      />
                                    ) : (
                                      <div className="flex h-full w-full items-center justify-center bg-brand-danger/20 text-[10px] font-bold text-foreground-primary">
                                        {placedHero.hero?.name?.charAt(0)}
                                      </div>
                                    )}
                                  </div>

                                  {/* Стрілка напрямку — єдиний елемент, що обертається та рухається по краю клітинки */}
                                  <span
                                    aria-hidden="true"
                                    className={`pointer-events-none absolute flex h-4 w-4 items-center justify-center rounded-full border border-white/70 bg-black/75 text-sm font-black leading-none text-white shadow-md transition-transform duration-150 ease-in-out ${direction.position}`}
                                    style={{
                                      transform: `rotate(${direction.angle}deg)`,
                                    }}
                                  >
                                    ↑
                                  </span>
                                </div>

                                {/* Ім'я героя */}
                                <span className="pointer-events-none absolute -top-4 left-1/2 z-30 -translate-x-1/2 whitespace-nowrap rounded bg-brand-danger px-1 py-0.5 text-[8px] font-bold text-white shadow-surface">
                                  {placedHero.hero?.name || 'Hero'}
                                </span>

                                {/* Хрестик видалення героя з мапи */}
                                <span
                                  role="button"
                                  tabIndex={0}
                                  aria-label={`Прибрати ${placedHero.hero?.name || 'героя'} з мапи`}
                                  title="Прибрати героя з мапи"
                                  onClick={(event) => {
                                    event.preventDefault();
                                    event.stopPropagation();
                                    removeHeroFromMap(placedHero.heroId);
                                  }}
                                  onKeyDown={(event) => {
                                    if (
                                      event.key === 'Enter' ||
                                      event.key === ' '
                                    ) {
                                      event.preventDefault();
                                      event.stopPropagation();
                                      removeHeroFromMap(placedHero.heroId);
                                    }
                                  }}
                                  className="absolute -right-1.5 -top-1.5 z-40 flex h-4 w-4 cursor-pointer items-center justify-center rounded-full border border-white/30 bg-brand-danger text-[10px] font-black leading-none text-white shadow-md transition hover:scale-110 hover:bg-brand-danger-hover focus-visible:outline-2 focus-visible:outline-offset-1 focus-visible:outline-brand-danger"
                                >
                                  ×
                                </span>
                              </>
                            )}
                          </button>
                        );
                      })
                    )}
                  </div>
                </div>
              </div>

              <p className="mt-2 text-center text-[10px] text-foreground-muted">
                {selectedHeroId
                  ? 'Вибери клітинку, щоб розмістити героя.'
                  : 'Клікни по іконці героя на мапі, щоб повернути стрілку напрямку за годинниковою стрілкою.'}
              </p>
            </section>

            {/* Бічна панель керування */}
            <aside className="flex min-w-0 flex-col gap-3 bg-surface-raised p-3">
              <div className="flex flex-wrap items-center justify-between gap-2 border-b border-surface-border pb-3">
                <h2 className="text-xs font-bold uppercase tracking-wider text-brand-accent">
                  Керування розстановкою
                </h2>

                <div className="flex items-center gap-1">
                  {MAP_TYPES.map((type) => {
                    const isActive = mapType === type.value;

                    return (
                      <button
                        key={type.value}
                        type="button"
                        onClick={() => setMapType(type.value)}
                        aria-pressed={isActive}
                        className={`rounded-lg border px-3 py-1.5 text-[10px] font-bold uppercase tracking-wider transition-colors focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-accent ${
                          isActive
                            ? 'border-brand-accent bg-brand-accent text-foreground-onAccent'
                            : 'border-surface-border bg-surface-sunken text-foreground-secondary hover:border-brand-accent/50 hover:text-foreground-primary'
                        }`}
                      >
                        {type.label}
                      </button>
                    );
                  })}
                </div>
              </div>

              {error && (
                <div
                  role="alert"
                  className="rounded-lg border border-brand-danger/30 bg-brand-danger/10 p-2.5 text-xs text-brand-danger-hover"
                >
                  {error}
                </div>
              )}

              {notice && (
                <div
                  role="status"
                  className="rounded-lg border border-brand-success/30 bg-brand-success/10 p-2.5 text-xs text-brand-success-hover"
                >
                  {notice}
                </div>
              )}

              {/* Форма пресету */}
              <div className="space-y-3 text-xs">
                <div>
                  <label
                    htmlFor="attack-code"
                    className="mb-1 block font-medium text-foreground-secondary"
                  >
                    Код пресету
                  </label>
                  <input
                    id="attack-code"
                    type="text"
                    value={attackCode}
                    onChange={(event) => setAttackCode(event.target.value)}
                    placeholder="Напр. f1-01"
                    className={inputClass}
                  />
                </div>

                <div>
                  <label
                    htmlFor="attack-name"
                    className="mb-1 block font-medium text-foreground-secondary"
                  >
                    Назва атаки
                  </label>
                  <input
                    id="attack-name"
                    type="text"
                    value={attackName}
                    onChange={(event) => setAttackName(event.target.value)}
                    placeholder="Напр. Стандартний прохід"
                    className={inputClass}
                  />
                </div>

                <div>
                  <label
                    htmlFor="attack-description"
                    className="mb-1 block font-medium text-foreground-secondary"
                  >
                    Опис
                  </label>
                  <textarea
                    id="attack-description"
                    value={description}
                    onChange={(event) => setDescription(event.target.value)}
                    placeholder="Додаткові нотатки..."
                    rows={3}
                    className={`${inputClass} resize-y`}
                  />
                </div>

               {/* Призначення гвг солдатів пресету атаки */}
               <div className="space-y-2 rounded-lg border border-surface-border bg-surface-sunken/40 p-2.5">
                 <label className="block font-medium text-foreground-secondary">
                   Гвг солдати в пресеті
                 </label>

                 <div className="flex flex-wrap items-center gap-2">
                  <div className="grid grid-cols-[minmax(0,1fr)_4.5rem] gap-2 sm:flex sm:items-center">
                    {/* Кастомний dropdown з картинками та rarity ring. */}
                    <div ref={demonSoldierDropdownRef} className="relative min-w-0 flex-1">
                      <button
                        type="button"
                        onClick={() =>
                          setIsDemonSoldierDropdownOpen((open) => !open)
                        }
                        aria-haspopup="listbox"
                        aria-expanded={isDemonSoldierDropdownOpen}
                        aria-label="Вибрати гвг солдата"
                        className={`flex min-h-11 w-full items-center gap-2 rounded-lg border bg-surface-sunken px-2.5 text-left text-sm outline-none transition-all ${
                          isDemonSoldierDropdownOpen
                            ? 'border-brand-accent bg-surface-raised shadow-[0_0_0_2px_rgba(245,158,11,0.12)]'
                            : 'border-surface-border hover:border-brand-accent/50 hover:bg-surface-raised'
                        }`}
                      >
                        {selectedDemonSoldier ? (
                          <>
                            <SoldierImage
                              soldier={selectedDemonSoldier}
                              className={`h-8 w-8 shrink-0 rounded-md ring-1 ${
                                RARITY_RING[selectedDemonSoldier.rarity] || 'ring-gray-600'
                              }`}
                              fallbackClassName="text-xs"
                            />
                            <span className="min-w-0 flex-1 truncate">
                              <span className="block truncate font-semibold text-foreground-primary">
                                {selectedDemonSoldier.name}
                              </span>
                              <span className="block truncate text-[10px] text-foreground-muted">
                                {selectedDemonSoldier.rarity || 'Common'} · рівень {selectedDemonSoldier.level ?? 1}
                              </span>
                            </span>
                          </>
                        ) : (
                          <>
                            <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-md border border-surface-border bg-surface-overlay text-sm text-foreground-muted">
                              ⚡
                            </span>
                            <span className="min-w-0 flex-1 truncate text-foreground-muted">
                              Обери солдата…
                            </span>
                          </>
                        )}

                        <span
                          aria-hidden="true"
                          className={`shrink-0 text-xs text-foreground-muted transition-transform duration-150 ${
                            isDemonSoldierDropdownOpen ? 'rotate-180' : ''
                          }`}
                        >
                          ▾
                        </span>
                      </button>

                      {isDemonSoldierDropdownOpen && (
                        <div className="absolute inset-x-0 top-full z-[80] mt-1 overflow-hidden rounded-xl border border-surface-border bg-surface-raised shadow-2xl ring-1 ring-black/30">
                          <div className="border-b border-surface-border bg-surface-raised p-2">
                            <input
                              type="search"
                              value={demonSoldierSearchQuery}
                              onChange={(event) =>
                                setDemonSoldierSearchQuery(event.target.value)
                              }
                              onKeyDown={(event) => {
                                if (event.key === 'Escape') {
                                  setIsDemonSoldierDropdownOpen(false);
                                }
                              }}
                              autoFocus
                              placeholder="Пошук солдата..."
                              aria-label="Пошук гвг солдата"
                              className={`${inputClass} h-9 bg-surface-sunken text-xs`}
                            />
                          </div>

                          <div
                            className="max-h-[50vh] overflow-y-auto overscroll-contain p-1 sm:max-h-72"
                            role="listbox"
                            aria-label="Список гвг солдатів"
                          >
                            {visibleDemonSoldiers.length === 0 ? (
                              <div className="px-3 py-5 text-center text-xs text-foreground-muted">
                                Солдатів не знайдено.
                              </div>
                            ) : (
                              visibleDemonSoldiers.map((soldier) => {
                                const rarityRing =
                                  RARITY_RING[soldier.rarity] || 'ring-gray-600';
                                const isSelected =
                                  String(selectedDemonSoldierId) ===
                                  String(soldier.id);

                                return (
                                  <button
                                    key={soldier.id}
                                    type="button"
                                    role="option"
                                    aria-selected={isSelected}
                                    onClick={() => selectDemonSoldier(soldier)}
                                    className={`group flex w-full items-center gap-2.5 rounded-lg px-2 py-2 text-left transition-colors ${
                                      isSelected
                                        ? 'bg-brand-accent/10 ring-1 ring-brand-accent/50'
                                        : 'hover:bg-surface-sunken'
                                    }`}
                                  >
                                    <SoldierImage
                                      soldier={soldier}
                                      className={`h-10 w-10 shrink-0 rounded-lg ring-2 ${rarityRing}`}
                                      fallbackClassName="text-sm"
                                    />

                                    <span className="min-w-0 flex-1">
                                      <span className="flex items-center gap-1.5">
                                        <span className="truncate text-xs font-semibold text-foreground-primary">
                                          {soldier.name}
                                        </span>
                                        {isSelected && (
                                          <span className="shrink-0 text-[10px] font-bold text-brand-accent">
                                            ✓
                                          </span>
                                        )}
                                      </span>

                                      <span className="mt-0.5 flex flex-wrap items-center gap-x-1.5 gap-y-0.5 text-[10px] text-foreground-muted">
                                        <span
                                          className={
                                            soldier.rarity === 'Legendary'
                                              ? 'text-amber-400'
                                              : soldier.rarity === 'Epic'
                                                ? 'text-purple-400'
                                                : soldier.rarity === 'Rare'
                                                  ? 'text-blue-400'
                                                  : 'text-foreground-muted'
                                          }
                                        >
                                          {soldier.rarity || 'Common'}
                                        </span>
                                        <span>·</span>
                                        <span>рівень {soldier.level ?? 1}</span>
                                      </span>
                                    </span>
                                  </button>
                                );
                              })
                            )}
                          </div>
                        </div>
                      )}
                    </div>

                    <input
                      type="number"
                      min={1}
                      value={demonSoldierQuantity}
                      onChange={(event) =>
                        setDemonSoldierQuantity(event.target.value)
                      }
                      aria-label="Кількість солдатів"
                      className={`${inputClass} h-11 w-full shrink-0 sm:w-16`}
                    />

                    <button
                      type="button"
                      onClick={addPresetSoldier}
                      className={`${buttonSecondaryClass} col-span-2 min-h-10 w-full sm:w-auto`}
                    >
                      Додати
                    </button>
                  </div>
                  </div>

                 {presetSoldiers.length === 0 ? (
                   <p className="text-[11px] text-foreground-muted">
                     Гвг солдатів ще не призначено.
                   </p>
                 ) : (
                   <ul className="space-y-1">
                     {presetSoldiers.map((item) => {
                       const soldierData = item.demonSoldier || demonSoldiers.find(s => s.id === item.demonSoldierId);
                       const rarityRing = RARITY_RING[soldierData?.rarity] || 'ring-gray-600';

                       return (
                         <li
                           key={item.demonSoldierId}
                           className="flex min-w-0 items-center justify-between gap-2 rounded-lg border border-surface-border bg-surface-base px-2.5 py-2 text-[11px]"
                         >
                           <div className="flex items-center gap-2 truncate">
                             {/* Іконка солдата в списку доданих з рамкою рідкості */}
                             <SoldierImage
                               soldier={soldierData}
                               className={`h-8 w-8 shrink-0 rounded-md ring-1 ${rarityRing}`}
                               fallbackClassName="text-[10px]"
                             />

                             <span className="truncate text-foreground-primary font-medium">
                               {soldierData?.name || `Солдат #${item.demonSoldierId}`}
                               <span className="ml-1 text-foreground-muted font-normal">
                                 × {item.quantity}
                               </span>
                             </span>
                           </div>

                           <button
                             type="button"
                             onClick={() =>
                               removePresetSoldier(item.demonSoldierId)
                             }
                             aria-label="Видалити солдата з пресету"
                             title="Видалити солдата з пресету"
                             className="flex h-5 w-5 shrink-0 items-center justify-center rounded-md text-xs font-black text-brand-danger transition-colors hover:bg-brand-danger/15 hover:text-brand-danger-hover focus-visible:outline-2 focus-visible:outline-brand-danger"
                           >
                             ×
                           </button>
                         </li>
                       );
                     })}
                   </ul>
                 )}
               </div>

                <div className="flex gap-2 pt-1">
                  <button
                    type="button"
                    onClick={savePreset}
                    disabled={saving}
                    className={`${buttonPrimaryClass} flex-1`}
                  >
                    {saving ? 'Збереження…' : 'Зберегти'}
                  </button>

                  <button
                    type="button"
                    onClick={resetRecord}
                    className={buttonSecondaryClass}
                  >
                    Скинути
                  </button>
                </div>
              </div>

              {/* Пошук пресету */}
              <div className="space-y-2 border-t border-surface-border pt-3">
                <label
                  htmlFor="search-code"
                  className="block text-xs font-semibold text-foreground-secondary"
                >
                  Знайти за кодом
                </label>

                <div className="flex gap-2">
                  <input
                    id="search-code"
                    type="text"
                    value={searchCode}
                    onChange={(event) => setSearchCode(event.target.value)}
                    onKeyDown={(event) => {
                      if (event.key === 'Enter') findPresetByCode();
                    }}
                    placeholder="Код пресету..."
                    className={`${inputClass} min-w-0`}
                  />

                  <button
                    type="button"
                    onClick={findPresetByCode}
                    className={buttonSecondaryClass}
                  >
                    Знайти
                  </button>
                </div>
              </div>

              {/* Список пресетів */}
              <div className="flex min-h-0 flex-1 flex-col border-t border-surface-border pt-3">
                <div className="mb-2 flex items-center justify-between gap-2">
                  <h3 className="text-xs font-bold text-foreground-secondary">
                    Збережені пресети
                  </h3>

                  <span className="rounded-full border border-surface-border bg-surface-sunken px-2 py-0.5 text-[10px] font-semibold text-foreground-muted">
                    {presets.length}
                  </span>
                </div>

                <div className="max-h-48 space-y-1.5 overflow-y-auto pr-1">
                  {presets.length === 0 ? (
                    <p className="rounded-lg border border-dashed border-surface-border px-3 py-4 text-center text-xs text-foreground-muted">
                      Збережених пресетів поки немає.
                    </p>
                  ) : (
                    presets.map((preset) => {
                      const isOpened =
                        openedPreset?.preset?.id === preset.id;

                      return (
                        <button
                          key={preset.id}
                          type="button"
                          onClick={() => openPreset(preset.id)}
                          aria-pressed={isOpened}
                          className={`w-full rounded-lg border p-2 text-left transition-colors focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-accent ${
                            isOpened
                              ? 'border-brand-accent bg-brand-accent/10'
                              : 'border-surface-border bg-surface-base hover:border-brand-accent/40 hover:bg-surface-sunken'
                          }`}
                        >
                          <div className="font-mono text-xs font-bold text-brand-accent">
                            {preset.presetCode}
                          </div>
                          <div className="mt-0.5 truncate text-[11px] text-foreground-secondary">
                            {preset.name}
                          </div>
                        </button>
                      );
                    })
                  )}
                </div>
              </div>
            </aside>
          </div>

          {/* Каталог героїв */}
          <section className="border-t border-surface-border bg-surface-raised p-3">
            <div className="mb-3 flex flex-col gap-3 xl:flex-row xl:items-center xl:justify-between">
              <div className="flex flex-wrap items-center gap-2">
                <h3 className="text-xs font-bold uppercase tracking-wider text-brand-accent">
                  Каталог героїв
                </h3>

                <span className="rounded-full border border-surface-border bg-surface-sunken px-2 py-0.5 text-[10px] font-semibold text-foreground-muted">
                  {visibleHeroes.length}
                </span>

                {selectedHeroId && (
                  <span className="rounded-full border border-brand-success/30 bg-brand-success/10 px-2 py-1 text-[10px] font-semibold text-brand-success-hover">
                    Герой вибраний для розміщення
                  </span>
                )}
              </div>

              <div className="flex flex-wrap items-center gap-2">
                <div className="relative w-full sm:w-40">
                  <input
                    type="text"
                    value={heroSearchQuery}
                    onChange={(event) =>
                      setHeroSearchQuery(event.target.value)
                    }
                    placeholder="Пошук героя..."
                    aria-label="Пошук героя"
                    className={`${inputClass} py-1.5 pr-8 text-xs`}
                  />

                  {(heroSearchQuery || classFilter !== 'ALL') && (
                    <button
                      type="button"
                      onClick={clearHeroFilters}
                      aria-label="Скинути пошук та фільтри"
                      title="Скинути пошук та фільтри"
                      className="absolute right-1.5 top-1/2 flex h-6 w-6 -translate-y-1/2 items-center justify-center rounded-md text-sm font-bold text-brand-danger transition-colors hover:bg-brand-danger/10 hover:text-brand-danger-hover focus-visible:outline-2 focus-visible:outline-brand-danger"
                    >
                      ×
                    </button>
                  )}
                </div>

                <select
                  value={classFilter}
                  onChange={(event) => setClassFilter(event.target.value)}
                  aria-label="Фільтр за класом"
                  className="rounded-lg border border-surface-border bg-surface-sunken px-2.5 py-1.5 text-xs text-foreground-primary outline-none transition-colors focus:border-brand-accent"
                >
                  <option value="ALL">Усі класи</option>
                  {heroClasses.map((className) => (
                    <option key={className} value={className}>
                      {className}
                    </option>
                  ))}
                </select>

                <select
                  value={sortBy}
                  onChange={(event) => setSortBy(event.target.value)}
                  aria-label="Сортування героїв"
                  className="rounded-lg border border-surface-border bg-surface-sunken px-2.5 py-1.5 text-xs text-foreground-primary outline-none transition-colors focus:border-brand-accent"
                >
                  <option value="NAME">За ім'ям</option>
                  <option value="CLASS">За класом</option>
                </select>

                <div className="flex gap-1">
                  <button
                    type="button"
                    onClick={() => scrollHeroList(-1)}
                    aria-label="Прокрутити каталог ліворуч"
                    title="Ліворуч"
                    className={buttonSecondaryClass}
                  >
                    ←
                  </button>

                  <button
                    type="button"
                    onClick={() => scrollHeroList(1)}
                    aria-label="Прокрутити каталог праворуч"
                    title="Праворуч"
                    className={buttonSecondaryClass}
                  >
                    →
                  </button>
                </div>
              </div>
            </div>

            {visibleHeroes.length === 0 ? (
              <div className="rounded-xl border border-dashed border-surface-border bg-surface-base p-6 text-center text-xs text-foreground-muted">
                Героїв за вибраними фільтрами не знайдено.
              </div>
            ) : (
              <div
                ref={heroListRef}
                className="flex gap-2.5 overflow-x-auto pb-2"
              >
                {visibleHeroes.map((hero) => {
                  const isSelected = selectedHeroId === hero.id;
                  const placement = heroPlacements[hero.id];
                  const rarityRing =
                    RARITY_RING[hero.rarity] || 'ring-gray-600';

                  return (
                    <div
                      key={hero.id}
                      onClick={() => selectHero(hero)}
                      onKeyDown={(event) => {
                        if (
                          event.target === event.currentTarget &&
                          (event.key === 'Enter' || event.key === ' ')
                        ) {
                          event.preventDefault();
                          selectHero(hero);
                        }
                      }}
                      role="button"
                      tabIndex={0}
                      aria-pressed={isSelected}
                      title={
                        placement
                          ? `${hero.name} — (${placement.x}, ${placement.y})`
                          : `Вибрати ${hero.name}`
                      }
                      className={`group relative w-24 flex-shrink-0 cursor-pointer select-none rounded-xl border p-2 text-left transition-colors focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-accent ${
                        isSelected
                          ? 'border-brand-accent bg-brand-accent/10 shadow-brand-accent'
                          : placement
                            ? 'border-brand-success/50 bg-brand-success/5'
                            : 'border-surface-border bg-surface-base hover:border-brand-accent/50 hover:bg-surface-sunken'
                      }`}
                    >
                      <div className="relative mx-auto h-14 w-14 rounded-lg bg-surface-overlay">
                        {hero.imageSlug ? (
                          <img
                            src={`/images/heroes/${hero.imageSlug}.png`}
                            alt={hero.name}
                            draggable="false"
                            className={`h-full w-full rounded-lg object-cover ring-2 ${rarityRing}`}
                          />
                        ) : (
                          <div
                            className={`flex h-full w-full items-center justify-center rounded-lg bg-surface-sunken text-sm font-bold text-brand-accent ring-2 ${rarityRing}`}
                          >
                            {hero.name?.charAt(0)}
                          </div>
                        )}

                        {placement && (
                          <span
                            className="absolute -right-1 -top-1 flex h-4 w-4 items-center justify-center rounded-full border border-surface-raised bg-brand-success text-[9px] font-bold text-white shadow-sm"
                            aria-label="Героя розміщено"
                            title="Розміщено на мапі"
                          >
                            ✓
                          </span>
                        )}
                      </div>

                      <p className="mt-2 truncate text-center text-[10px] font-bold text-foreground-primary">
                        {hero.name}
                      </p>

                      <p className="truncate text-center text-[9px] text-foreground-muted">
                        {hero.className || 'Hero'}
                      </p>

                      {placement && (
                        <div className="mt-2 flex items-center justify-between gap-1 border-t border-surface-border pt-1.5">
                          <span className="font-mono text-[9px] text-brand-success-hover">
                            ({placement.x},{placement.y})
                          </span>

                          <button
                            type="button"
                            aria-label={`Прибрати ${hero.name} з мапи`}
                            title="Прибрати з мапи"
                            onClick={(event) => {
                              event.stopPropagation();
                              removeHeroFromMap(hero.id);
                            }}
                            className="flex h-5 w-5 items-center justify-center rounded-md text-xs font-black text-brand-danger transition-colors hover:bg-brand-danger/15 hover:text-brand-danger-hover focus-visible:outline-2 focus-visible:outline-brand-danger"
                          >
                            ×
                          </button>
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            )}

            {/* Легенда */}
            <div className="mt-3 flex flex-wrap items-center gap-x-4 gap-y-2 border-t border-surface-border pt-3 text-[10px] text-foreground-muted">
              <span className="flex items-center gap-1.5">
                <span className="h-2.5 w-2.5 rounded-sm border border-brand-accent bg-brand-accent/20" />
                Вибраний герой
              </span>

              <span className="flex items-center gap-1.5">
                <span className="h-2.5 w-2.5 rounded-sm border border-brand-success bg-brand-success/20" />
                Героя розміщено
              </span>

              <span className="flex items-center gap-1.5">
                <span className="flex h-3 w-3 items-center justify-center rounded-full bg-brand-danger text-[9px] font-bold text-white">
                  ×
                </span>
                Прибрати героя з мапи
              </span>

              <span className="flex items-center gap-1.5">
                <span className="flex h-4 w-4 items-center justify-center rounded-full border border-surface-border bg-surface-sunken text-xs font-bold text-foreground-primary">
                  ↑
                </span>
                Клік по герою повертає стрілку напрямку на 90° (іконка героя нерухома)
              </span>
            </div>
          </section>
        </div>
      )}
    </div>
  );
}
