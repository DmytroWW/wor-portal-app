import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import api from '../../api/axios';

const MAP_TYPES = [
  { value: 'FORT', label: 'Fort' },
  { value: 'TOWER', label: 'Tower' },
];

const DIRECTIONS = [
  { value: 'UP', label: '↑ Вгору' },
  { value: 'DOWN', label: '↓ Вниз' },
  { value: 'LEFT', label: '← Вліво' },
  { value: 'RIGHT', label: '→ Вправо' },
];

const RARITY_RING = {
  Common: 'ring-gray-400',
  Uncommon: 'ring-green-400',
  Rare: 'ring-blue-400',
  Epic: 'ring-purple-400',
  Legendary: 'ring-amber-400',
};

const errorMessage = (error) =>
  error?.response?.data?.message ||
  error?.response?.data?.error ||
  error?.message ||
  'Сталася помилка запиту.';

export default function GvgPage() {
  const [mapType, setMapType] = useState('FORT');

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

  const [classFilter, setClassFilter] = useState('ALL');
  const [sortBy, setSortBy] = useState('NAME');

  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [loadingPreset, setLoadingPreset] = useState(false);

  const [error, setError] = useState('');
  const [notice, setNotice] = useState('');

  const heroListRef = useRef(null);

  // =========================================================
  // LOAD ACTIVE MAP
  // =========================================================

  const loadMap = useCallback(async () => {
    setLoading(true);
    setError('');
    setNotice('');
    setOpenedPreset(null);

    try {
      const mapResponse = await api.get(`/gvg/maps/active?type=${mapType}`);
      const activeMap = mapResponse.data;

      setMap(activeMap);

      const tilesResponse = await api.get(`/gvg/maps/${activeMap.id}/tiles`);

      setTiles(Array.isArray(tilesResponse.data) ? tilesResponse.data : []);

      setHeroPlacements({});
      setSelectedHeroId(null);
    } catch (err) {
      setMap(null);
      setTiles([]);
      setError(errorMessage(err));
    } finally {
      setLoading(false);
    }
  }, [mapType]);

  // =========================================================
  // LOAD HERO CATALOG
  // =========================================================

  const loadHeroes = useCallback(async () => {
    try {
      const response = await api.get('/heroes');
      setHeroes(Array.isArray(response.data) ? response.data : []);
    } catch (err) {
      setError(errorMessage(err));
    }
  }, []);

  // =========================================================
  // LOAD SAVED PRESETS
  // =========================================================

  const loadPresets = useCallback(async () => {
    try {
      const response = await api.get('/gvg/presets');
      setPresets(Array.isArray(response.data) ? response.data : []);
    } catch (err) {
      setError(errorMessage(err));
    }
  }, []);

  useEffect(() => {
    loadHeroes();
    loadPresets();
  }, [loadHeroes, loadPresets]);

  useEffect(() => {
    loadMap();
  }, [loadMap]);

  // =========================================================
  // TILE LOOKUP
  // =========================================================

  const tileLookup = useMemo(() => {
    const lookup = new Map();
    tiles.forEach((tile) => lookup.set(`${tile.x},${tile.y}`, tile));
    return lookup;
  }, [tiles]);

  // =========================================================
  // OCCUPIED TILES
  // =========================================================

  const occupiedTileIds = useMemo(() => {
    return new Set(
      Object.values(heroPlacements)
        .map((placement) => placement.tileId)
        .filter(Boolean)
    );
  }, [heroPlacements]);

  // =========================================================
  // SELECT HERO
  // =========================================================

  const selectHero = (hero) => {
    setError('');
    setNotice('');
    setSelectedHeroId((current) => (current === hero.id ? null : hero.id));
  };

  // =========================================================
  // PLACE HERO
  // =========================================================

  const placeHero = (tile) => {
    if (!selectedHeroId) {
      setError('Спочатку вибери героя зі списку внизу.');
      return;
    }

    if (!tile) return;

    if (tile.tileType === 'EMPTY') {
      setError('На порожню клітинку героя поставити не можна.');
      return;
    }

    if (occupiedTileIds.has(tile.id)) {
      setError('Ця клітинка вже зайнята іншим героєм.');
      return;
    }

    const existingPlacement = heroPlacements[selectedHeroId];

    setHeroPlacements((current) => ({
      ...current,
      [selectedHeroId]: {
        heroId: selectedHeroId,
        tileId: tile.id,
        x: tile.x,
        y: tile.y,
        attackDirection: existingPlacement?.attackDirection || 'DOWN',
      },
    }));

    setNotice(`Героя розміщено на (${tile.x}, ${tile.y}).`);
  };

  // =========================================================
  // CHANGE DIRECTION
  // =========================================================

  const changeDirection = (heroId, direction) => {
    setHeroPlacements((current) => {
      const placement = current[heroId];
      if (!placement) return current;

      return {
        ...current,
        [heroId]: { ...placement, attackDirection: direction },
      };
    });
  };

  // =========================================================
  // REMOVE HERO FROM MAP
  // =========================================================

  const removeHeroFromMap = (heroId) => {
    setHeroPlacements((current) => {
      const copy = { ...current };
      delete copy[heroId];
      return copy;
    });

    if (selectedHeroId === heroId) {
      setSelectedHeroId(null);
    }
  };

  // =========================================================
  // RESET FORM ("Скинути запис")
  // =========================================================

  const resetRecord = () => {
    setHeroPlacements({});
    setSelectedHeroId(null);
    setAttackCode('');
    setAttackName('');
    setDescription('');
    setSearchCode('');
    setOpenedPreset(null);
    setError('');
    setNotice('Запис скинуто. Можна почати нову розстановку.');
  };

  // =========================================================
  // SAVE PRESET ("Записати журнал атак")
  // =========================================================

  const savePreset = async () => {
    setError('');
    setNotice('');

    if (!map) {
      setError('Активну мапу не завантажено.');
      return;
    }

    if (!attackCode.trim()) {
      setError('Введи код свого пресету.');
      return;
    }

    if (!attackName.trim()) {
      setError('Введи назву атаки.');
      return;
    }

    const placements = Object.values(heroPlacements);

    if (placements.length === 0) {
      setError('Постав хоча б одного героя на мапу.');
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

      setNotice(`Журнал атаки «${preset.presetCode}» записано.`);
      setOpenedPreset(null);

      await loadPresets();
    } catch (err) {
      setError(errorMessage(err));
    } finally {
      setSaving(false);
    }
  };

  // =========================================================
  // PUBLISH ("Опублікувати журнал атак") — копіює код у буфер обміну
  // =========================================================

  const publishRecord = async () => {
    setError('');
    setNotice('');

    if (!attackCode.trim()) {
      setError('Спочатку запиши журнал атак із кодом пресету.');
      return;
    }

    try {
      await navigator.clipboard.writeText(attackCode.trim());
      setNotice(`Код «${attackCode.trim()}» скопійовано в буфер обміну. Поділись ним із гільдією.`);
    } catch {
      setNotice(`Код твого пресету: ${attackCode.trim()}`);
    }
  };

  const copyToClipboard = async (value, label) => {
    if (!value) return;

    try {
      await navigator.clipboard.writeText(value);
      setNotice(`${label} скопійовано: ${value}`);
    } catch {
      setNotice(`${label}: ${value}`);
    }
  };

  // =========================================================
  // OPEN SAVED PRESET
  // =========================================================

  const openPreset = async (presetId) => {
    setLoadingPreset(true);
    setError('');
    setNotice('');

    try {
      const response = await api.get(`/gvg/presets/${presetId}/details`);
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

      setNotice(`Завантажено атаку «${details.preset?.presetCode}».`);
    } catch (err) {
      setError(errorMessage(err));
    } finally {
      setLoadingPreset(false);
    }
  };

  // =========================================================
  // SEARCH / COUNTER CODE LOOKUP
  // =========================================================

  const findPresetByCode = () => {
    const normalized = searchCode.trim().toLowerCase();

    if (!normalized) {
      setError('Введи код оборони, яку хочеш законтрити.');
      return;
    }

    const found = presets.find(
      (preset) => preset.presetCode?.toLowerCase() === normalized
    );

    if (!found) {
      setError(`Атаку з кодом «${searchCode.trim()}» не знайдено.`);
      return;
    }

    openPreset(found.id);
  };

  // =========================================================
  // CURRENT PLACED HEROES
  // =========================================================

  const placedHeroes = useMemo(() => {
    return Object.values(heroPlacements)
      .map((placement) => {
        const hero = heroes.find((item) => item.id === placement.heroId);
        return { ...placement, hero };
      })
      .filter((item) => item.hero);
  }, [heroPlacements, heroes]);

  // =========================================================
  // HERO LIST — FILTER / SORT
  // =========================================================

  const heroClasses = useMemo(() => {
    return [...new Set(heroes.map((hero) => hero.className).filter(Boolean))].sort();
  }, [heroes]);

  const visibleHeroes = useMemo(() => {
    let list = heroes;

    if (classFilter !== 'ALL') {
      list = list.filter((hero) => hero.className === classFilter);
    }

    list = [...list].sort((a, b) => {
      if (sortBy === 'CLASS') {
        return (a.className || '').localeCompare(b.className || '') ||
          (a.name || '').localeCompare(b.name || '');
      }
      return (a.name || '').localeCompare(b.name || '');
    });

    return list;
  }, [heroes, classFilter, sortBy]);

  const scrollHeroList = (direction) => {
    if (!heroListRef.current) return;
    heroListRef.current.scrollBy({ left: direction * 260, behavior: 'smooth' });
  };

  // =========================================================
  // LOADING
  // =========================================================

  if (loading) {
    return (
      <div className="mx-auto max-w-7xl">
        <div className="rounded-2xl border border-amber-900/50 bg-stone-950 p-10 text-center text-amber-200/70">
          Завантаження GvG мапи…
        </div>
      </div>
    );
  }

  // =========================================================
  // RENDER
  // =========================================================

  return (
    <div className="mx-auto max-w-7xl space-y-5 text-slate-100">

      {/* MAP TYPE TABS */}
      <div className="flex flex-wrap items-center gap-2">
        {MAP_TYPES.map((type) => (
          <button
            key={type.value}
            type="button"
            onClick={() => setMapType(type.value)}
            className={`rounded-lg px-4 py-2 text-xs font-bold uppercase tracking-wider transition ${
              mapType === type.value
                ? 'bg-amber-600 text-black shadow-lg shadow-amber-900/40'
                : 'border border-amber-900/50 bg-stone-900 text-amber-200/60 hover:bg-stone-800'
            }`}
          >
            {type.label}
          </button>
        ))}
      </div>

      {error && (
        <div className="rounded-xl border border-red-500/40 bg-red-950/40 p-3 text-sm text-red-300">
          {error}
        </div>
      )}

      {notice && (
        <div className="rounded-xl border border-emerald-500/30 bg-emerald-950/30 p-3 text-sm text-emerald-300">
          {notice}
        </div>
      )}

      {!map ? (
        <div className="rounded-2xl border border-dashed border-amber-900/50 bg-stone-950 p-10 text-center text-amber-200/60">
          Для цього типу зараз немає активної GvG мапи.
        </div>
      ) : (
        <div className="overflow-hidden rounded-2xl border-2 border-amber-900/60 bg-black shadow-2xl">

          <div className="grid gap-0 lg:grid-cols-[minmax(0,1fr)_320px]">

            {/* ================= MAP / BATTLEFIELD PANEL ================= */}
            <div className="relative border-b-2 border-amber-900/50 lg:border-b-0 lg:border-r-2">

              {/* TOP OVERLAY BAR */}
              <div className="absolute inset-x-0 top-0 z-30 flex items-start justify-between gap-3 bg-gradient-to-b from-black/90 to-transparent p-4">
                <div>
                  <h1 className="text-lg font-extrabold tracking-wide text-slate-50 drop-shadow-[0_2px_2px_rgba(0,0,0,0.9)] sm:text-xl">
                    Enemy Defense Setup — {map.name}
                  </h1>
                  <div className="mt-1.5 flex items-center gap-2 text-xs">
                    <span className="rounded bg-red-800/80 px-2 py-0.5 font-bold text-red-100">
                      lv{map.width * map.height}
                    </span>
                    <span className="rounded border border-sky-400/50 bg-sky-900/60 px-2 py-0.5 font-bold text-sky-200">
                      Block {placedHeroes.length}
                    </span>
                  </div>
                </div>

                <span className="rounded-full border border-emerald-500/40 bg-emerald-900/50 px-3 py-1 text-[10px] font-bold uppercase text-emerald-300">
                  Active Map
                </span>
              </div>

              {/* FORMATION VIEWER LABEL */}
              <div className="absolute inset-x-0 top-20 z-20 text-center sm:top-24">
                <p className="text-sm font-bold uppercase tracking-widest text-amber-200/90 drop-shadow-[0_2px_2px_rgba(0,0,0,0.9)]">
                  Enemy Formation Viewer
                </p>
                <p className="text-xs text-slate-300/80 drop-shadow-[0_2px_2px_rgba(0,0,0,0.9)]">
                  Перегляд ворожої формації
                </p>
              </div>

              {/* BATTLEFIELD BACKGROUND */}
              <div
                className="relative flex min-h-[420px] items-center justify-center bg-stone-900 pt-32 pb-6"
                style={{
                  backgroundImage: `url(${
                    mapType === 'FORT'
                      ? '/images/maps/fort-bg.png'
                      : '/images/maps/tower-bg.png'
                  })`,
                  backgroundSize: 'cover',
                  backgroundPosition: 'center',
                }}
              >
                <div className="absolute inset-0 bg-gradient-to-b from-black/50 via-transparent to-black/60" />

                <div className="relative overflow-x-auto px-3">
                  <div
                    className="mx-auto grid gap-1"
                    style={{ gridTemplateColumns: `repeat(${map.width}, minmax(34px, 1fr))` }}
                  >
                    {Array.from({ length: map.height }, (_, y) =>
                      Array.from({ length: map.width }, (_, x) => {
                        const tile = tileLookup.get(`${x},${y}`);

                        if (!tile || tile.tileType === 'EMPTY') {
                          return <div key={`${x}-${y}`} className="h-9 w-9 sm:h-10 sm:w-10" />;
                        }

                        const placedHero = placedHeroes.find((item) => item.tileId === tile.id);

                        return (
                          <button
                            key={`${x}-${y}`}
                            type="button"
                            onClick={() => placeHero(tile)}
                            className={`relative flex h-9 w-9 items-center justify-center rounded border transition sm:h-10 sm:w-10 ${
                              placedHero
                                ? 'border-red-500 bg-red-950/70 shadow-[0_0_12px_rgba(239,68,68,0.55)]'
                                : 'border-amber-200/25 bg-black/10 hover:border-amber-300/60 hover:bg-amber-500/10'
                            }`}
                            title={`X: ${x}, Y: ${y} · ${tile.tileType}`}
                          >
                            {placedHero && (
                              <>
                                <span className="pointer-events-none absolute -inset-0.5 rounded border-2 border-red-500/80" />
                                <div className="absolute inset-0.5 overflow-hidden rounded">
                                  {placedHero.hero?.imageSlug ? (
                                    <img
                                      src={`/images/heroes/${placedHero.hero.imageSlug}.png`}
                                      alt={placedHero.hero.name}
                                      className="h-full w-full object-cover"
                                    />
                                  ) : (
                                    <div className="flex h-full w-full items-center justify-center bg-red-900 text-[10px] font-bold text-white">
                                      {placedHero.hero?.name?.charAt(0)}
                                    </div>
                                  )}
                                </div>
                                <div className="absolute -top-5 left-1/2 z-20 -translate-x-1/2 whitespace-nowrap rounded bg-red-800/95 px-1.5 py-0.5 text-[8px] font-bold uppercase text-red-50 shadow">
                                  Ворожий
                                </div>
                              </>
                            )}
                          </button>
                        );
                      })
                    )}
                  </div>
                </div>
              </div>

              {/* PLACEMENT LIST / DIRECTIONS */}
              <div className="border-t border-amber-900/40 bg-stone-950/90 p-3">
                <p className="mb-2 text-xs font-bold uppercase tracking-wider text-amber-300/80">
                  {selectedHeroId
                    ? 'Натисни клітинку на мапі, щоб поставити героя'
                    : 'Розстановка на полі бою'}
                </p>

                {placedHeroes.length === 0 ? (
                  <p className="text-sm text-slate-500">Поки що жодного героя не поставлено.</p>
                ) : (
                  <div className="flex flex-wrap gap-2">
                    {placedHeroes.map((item) => (
                      <div
                        key={item.heroId}
                        className="flex items-center gap-2 rounded-lg border border-amber-900/50 bg-black/40 px-2.5 py-1.5"
                      >
                        <span className="text-xs font-semibold text-slate-200">
                          {item.hero.name}
                        </span>
                        <span className="text-[10px] text-slate-500">
                          ({item.x},{item.y})
                        </span>

                        <select
                          value={item.attackDirection}
                          onChange={(event) => changeDirection(item.heroId, event.target.value)}
                          className="rounded border border-amber-900/50 bg-stone-900 px-1.5 py-0.5 text-[10px] text-amber-100"
                        >
                          {DIRECTIONS.map((direction) => (
                            <option key={direction.value} value={direction.value}>
                              {direction.label}
                            </option>
                          ))}
                        </select>

                        <button
                          type="button"
                          onClick={() => removeHeroFromMap(item.heroId)}
                          className="text-[11px] font-bold text-red-400 hover:text-red-300"
                        >
                          ✕
                        </button>
                      </div>
                    ))}
                  </div>
                )}
              </div>
            </div>

            {/* ================= SIDE PANEL — ATTACK CODE REDAKTOR ================= */}
            <aside className="flex flex-col bg-gradient-to-b from-stone-900 via-stone-950 to-black">

              <div className="border-b-2 border-red-900/60 bg-gradient-to-r from-red-950 via-red-900/60 to-red-950 px-4 py-3">
                <p className="text-center text-xs font-black uppercase tracking-[0.2em] text-amber-200">
                  GvG Attack Code Redaktor
                </p>
              </div>

              <div className="flex-1 space-y-4 p-4">

                {/* COUNTER-ATTACK CODE (search enemy defense) */}
                <div>
                  <label className="text-[11px] font-bold uppercase tracking-wider text-amber-300/80">
                    Counter-Attack Code
                  </label>
                  <div className="mt-1.5 flex gap-1.5">
                    <input
                      value={searchCode}
                      onChange={(event) => setSearchCode(event.target.value)}
                      onKeyDown={(event) => {
                        if (event.key === 'Enter') findPresetByCode();
                      }}
                      placeholder="WR-ATK-XXXX"
                      className="min-w-0 flex-1 rounded-md border border-amber-900/50 bg-black/60 px-2.5 py-2 font-mono text-sm text-amber-100 outline-none focus:border-amber-400"
                    />
                    <button
                      type="button"
                      onClick={() => copyToClipboard(searchCode.trim(), 'Counter-Attack Code')}
                      title="Скопіювати"
                      className="rounded-md border border-amber-900/50 bg-stone-900 px-2.5 text-amber-200 hover:bg-stone-800"
                    >
                      📋
                    </button>
                  </div>
                  <button
                    type="button"
                    onClick={findPresetByCode}
                    disabled={loadingPreset}
                    className="mt-1.5 w-full rounded-md border border-amber-700/50 bg-amber-900/20 py-1.5 text-xs font-semibold text-amber-200 hover:bg-amber-900/40 disabled:opacity-50"
                  >
                    {loadingPreset ? 'Пошук…' : 'Завантажити оборону за кодом'}
                  </button>
                </div>

                {/* YOUR PRESET CODE */}
                <div>
                  <label className="text-[11px] font-bold uppercase tracking-wider text-amber-300/80">
                    Код Вашого Пресету
                  </label>
                  <div className="mt-1.5 flex gap-1.5">
                    <input
                      value={attackCode}
                      onChange={(event) => setAttackCode(event.target.value)}
                      placeholder="WR-GVG-XXXX"
                      maxLength={100}
                      className="min-w-0 flex-1 rounded-md border border-amber-900/50 bg-black/60 px-2.5 py-2 font-mono text-sm text-amber-100 outline-none focus:border-amber-400"
                    />
                    <button
                      type="button"
                      onClick={() => copyToClipboard(attackCode.trim(), 'Код пресету')}
                      title="Скопіювати"
                      className="rounded-md border border-amber-900/50 bg-stone-900 px-2.5 text-amber-200 hover:bg-stone-800"
                    >
                      📋
                    </button>
                  </div>
                </div>

                <input
                  value={attackName}
                  onChange={(event) => setAttackName(event.target.value)}
                  placeholder="Назва атаки"
                  maxLength={100}
                  className="w-full rounded-md border border-amber-900/50 bg-black/60 px-2.5 py-2 text-sm text-slate-100 outline-none focus:border-amber-400"
                />

                {/* DESCRIPTION */}
                <div>
                  <label className="text-[11px] font-bold uppercase tracking-wider text-amber-300/80">
                    Description
                  </label>
                  <textarea
                    value={description}
                    onChange={(event) => setDescription(event.target.value)}
                    placeholder="[Ім'я героя] — опис тактики..."
                    rows={5}
                    className="mt-1.5 w-full resize-none rounded-md border border-amber-900/50 bg-black/60 px-2.5 py-2 text-xs leading-relaxed text-slate-200 outline-none focus:border-amber-400"
                  />
                </div>

                {/* SAVED ATTACKS QUICK LIST */}
                {presets.length > 0 && (
                  <div>
                    <p className="text-[11px] font-bold uppercase tracking-wider text-amber-300/80">
                      Мої збережені атаки
                    </p>
                    <div className="mt-1.5 max-h-32 space-y-1 overflow-y-auto pr-1">
                      {presets.map((preset) => (
                        <button
                          key={preset.id}
                          type="button"
                          onClick={() => openPreset(preset.id)}
                          className={`w-full rounded-md border px-2.5 py-1.5 text-left text-xs transition ${
                            openedPreset?.preset?.id === preset.id
                              ? 'border-amber-500 bg-amber-900/30'
                              : 'border-amber-900/40 bg-black/30 hover:bg-black/50'
                          }`}
                        >
                          <span className="font-mono font-bold text-amber-300">{preset.presetCode}</span>
                          <span className="ml-2 text-slate-400">{preset.name}</span>
                        </button>
                      ))}
                    </div>
                  </div>
                )}
              </div>

              {/* ACTION BUTTONS */}
              <div className="space-y-2 border-t-2 border-red-900/50 bg-black/50 p-4">
                <button
                  type="button"
                  onClick={savePreset}
                  disabled={saving}
                  className="w-full rounded-lg bg-gradient-to-b from-red-700 to-red-900 py-2.5 text-sm font-black uppercase tracking-wide text-red-50 shadow-lg shadow-red-950/60 transition hover:from-red-600 hover:to-red-800 disabled:opacity-50"
                >
                  {saving ? 'Збереження…' : 'Записати журнал атак'}
                </button>

                <button
                  type="button"
                  onClick={resetRecord}
                  className="w-full rounded-lg border border-red-800/60 bg-stone-900 py-2.5 text-sm font-black uppercase tracking-wide text-red-300 transition hover:bg-stone-800"
                >
                  Скинути запис
                </button>

                <button
                  type="button"
                  onClick={publishRecord}
                  className="w-full rounded-lg bg-gradient-to-b from-red-800 to-black py-2.5 text-sm font-black uppercase tracking-wide text-amber-200 shadow-lg shadow-black/60 transition hover:from-red-700"
                >
                  Опублікувати журнал атак
                </button>
              </div>
            </aside>
          </div>

          {/* ================= BOTTOM HERO LIST ================= */}
          <div className="border-t-2 border-amber-900/60 bg-stone-950 p-4">
            <div className="mb-3 flex flex-wrap items-center justify-between gap-3">
              <p className="text-xs font-black uppercase tracking-[0.25em] text-amber-300/90">
                Hero List
              </p>

              <div className="flex items-center gap-2">
                <select
                  value={classFilter}
                  onChange={(event) => setClassFilter(event.target.value)}
                  className="rounded-md border border-amber-900/50 bg-black/60 px-2.5 py-1.5 text-xs text-amber-100 outline-none focus:border-amber-400"
                >
                  <option value="ALL">Class: Усі</option>
                  {heroClasses.map((cls) => (
                    <option key={cls} value={cls}>
                      Class: {cls}
                    </option>
                  ))}
                </select>

                <select
                  value={sortBy}
                  onChange={(event) => setSortBy(event.target.value)}
                  className="rounded-md border border-amber-900/50 bg-black/60 px-2.5 py-1.5 text-xs text-amber-100 outline-none focus:border-amber-400"
                >
                  <option value="NAME">Sort: Ім'я</option>
                  <option value="CLASS">Sort: Клас</option>
                </select>
              </div>
            </div>

            <div className="relative flex items-center gap-2">
              <button
                type="button"
                onClick={() => scrollHeroList(-1)}
                className="shrink-0 rounded-full border border-amber-700/60 bg-black/70 p-2 text-amber-300 hover:bg-amber-900/30"
              >
                ‹
              </button>

              <div
                ref={heroListRef}
                className="flex flex-1 gap-2.5 overflow-x-auto scroll-smooth pb-1"
              >
                {visibleHeroes.map((hero) => {
                  const isSelected = selectedHeroId === hero.id;
                  const isPlaced = Boolean(heroPlacements[hero.id]);
                  const ring = RARITY_RING[hero.rarity] || 'ring-slate-500';

                  return (
                    <button
                      key={hero.id}
                      type="button"
                      onClick={() => selectHero(hero)}
                      className={`relative flex w-20 shrink-0 flex-col items-center rounded-lg border-2 bg-black/40 p-1 transition sm:w-24 ${
                        isSelected
                          ? 'border-amber-400 shadow-[0_0_14px_rgba(251,191,36,0.6)]'
                          : 'border-transparent hover:border-amber-600/60'
                      }`}
                    >
                      <div className={`relative h-16 w-16 overflow-hidden rounded ring-2 sm:h-20 sm:w-20 ${ring}`}>
                        {hero.imageSlug ? (
                          <img
                            src={`/images/heroes/${hero.imageSlug}.png`}
                            alt={hero.name}
                            className="h-full w-full object-cover"
                          />
                        ) : (
                          <div className="flex h-full w-full items-center justify-center bg-stone-800 text-xs text-slate-400">
                            {hero.name?.charAt(0)}
                          </div>
                        )}

                        {isPlaced && (
                          <span className="absolute right-0.5 top-0.5 flex h-4 w-4 items-center justify-center rounded-full bg-emerald-500 text-[9px] font-black text-black">
                            ✓
                          </span>
                        )}
                      </div>

                      <p className="mt-1 w-full truncate text-center text-[10px] font-bold text-slate-200">
                        {hero.name}
                      </p>
                      <p className="truncate text-[9px] uppercase text-amber-500/80">
                        {hero.className || 'CLASS'}
                      </p>
                    </button>
                  );
                })}

                {visibleHeroes.length === 0 && (
                  <p className="py-6 text-sm text-slate-500">Героїв за фільтром не знайдено.</p>
                )}
              </div>

              <button
                type="button"
                onClick={() => scrollHeroList(1)}
                className="shrink-0 rounded-full border border-amber-700/60 bg-black/70 p-2 text-amber-300 hover:bg-amber-900/30"
              >
                ›
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}