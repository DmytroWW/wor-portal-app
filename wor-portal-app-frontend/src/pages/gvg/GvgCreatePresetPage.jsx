import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import api from '../../api/axios';

const MAP_TYPES = [
  { value: 'FORT', label: 'Fort' },
  { value: 'TOWER', label: 'Tower' },
];

const MAX_HEROES_LIMIT = 5;
const FAVORITES_STORAGE_KEY = 'gvg_favorite_hero_ids';

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

const RESPONSIVE_GRID_CALIBRATION = {
  TOWER: [
    { width: 320, offsetX: 1, offsetY: -29, scale: 0.97, widthPct: 73, heightPct: 95 },
    { width: 332, offsetX: 2, offsetY: -29, scale: 0.97, widthPct: 73, heightPct: 95 },
    { width: 344, offsetX: 4, offsetY: -29, scale: 0.97, widthPct: 73, heightPct: 95 },
    { width: 350, offsetX: 5, offsetY: -28, scale: 0.97, widthPct: 73, heightPct: 95 },
    { width: 358, offsetX: 6, offsetY: -28, scale: 0.97, widthPct: 73, heightPct: 95 },
    { width: 365, offsetX: 7, offsetY: -28, scale: 0.97, widthPct: 73, heightPct: 95 },
    { width: 370, offsetX: 8, offsetY: -28, scale: 0.97, widthPct: 73, heightPct: 95 },
    { width: 380, offsetX: 5, offsetY: -33, scale: 0.94, widthPct: 76, heightPct: 100 },
    { width: 400, offsetX: 4, offsetY: -33, scale: 0.92, widthPct: 78, heightPct: 100 },
    { width: 432, offsetX: 7, offsetY: -33, scale: 0.92, widthPct: 78, heightPct: 100 },
    { width: 466, offsetX: 11, offsetY: -33, scale: 0.92, widthPct: 78, heightPct: 100 },
    { width: 494, offsetX: 13, offsetY: -33, scale: 0.92, widthPct: 78, heightPct: 100 },
    { width: 522, offsetX: 18, offsetY: -34, scale: 0.92, widthPct: 78, heightPct: 100 },
    { width: 558, offsetX: 22, offsetY: -34, scale: 0.92, widthPct: 78, heightPct: 100 },
    { width: 592, offsetX: 25, offsetY: -30, scale: 0.92, widthPct: 77, heightPct: 100 },
    { width: 636, offsetX: 33, offsetY: -30, scale: 0.92, widthPct: 77, heightPct: 100 },
    { width: 674, offsetX: 36, offsetY: -30, scale: 0.92, widthPct: 77, heightPct: 100 },
    { width: 724, offsetX: 42, offsetY: -30, scale: 0.92, widthPct: 77, heightPct: 100 },
    { width: 782, offsetX: 47, offsetY: -30, scale: 0.92, widthPct: 77, heightPct: 100 },
    { width: 856, offsetX: 54, offsetY: -30, scale: 0.92, widthPct: 77, heightPct: 100 },
    { width: 914, offsetX: 63, offsetY: -30, scale: 0.92, widthPct: 77, heightPct: 100 },
    { width: 960, offsetX: 70, offsetY: -30, scale: 0.92, widthPct: 77, heightPct: 100 },
    { width: 1022, offsetX: 74, offsetY: -30, scale: 0.92, widthPct: 77, heightPct: 100 },
    { width: 1030, offsetX: 40, offsetY: -30, scale: 0.92, widthPct: 77, heightPct: 100 },
    { width: 1076, offsetX: 45, offsetY: -30, scale: 0.92, widthPct: 77, heightPct: 100 },
    { width: 1142, offsetX: 51, offsetY: -30, scale: 0.92, widthPct: 77, heightPct: 100 },
    { width: 1190, offsetX: 60, offsetY: -30, scale: 0.92, widthPct: 76, heightPct: 100 },
    { width: 1264, offsetX: 69, offsetY: -30, scale: 0.92, widthPct: 76, heightPct: 100 },
    { width: 1745, offsetX: 72, offsetY: -30, scale: 0.92, widthPct: 78, heightPct: 100 },
  ],
  FORT: [
    { width: 382, offsetX: 2, offsetY: -37, scale: 0.948, widthPct: 78, heightPct: 105 },
    { width: 425, offsetX: 3, offsetY: -39, scale: 0.93, widthPct: 80, heightPct: 105 },
    { width: 495, offsetX: 10, offsetY: -39, scale: 0.93, widthPct: 80, heightPct: 105 },
    { width: 554, offsetX: 16, offsetY: -41, scale: 0.93, widthPct: 80, heightPct: 105 },
    { width: 586, offsetX: 23, offsetY: -42, scale: 0.93, widthPct: 79, heightPct: 105 },
    { width: 666, offsetX: 29, offsetY: -47, scale: 0.93, widthPct: 79, heightPct: 107 },
    { width: 749, offsetX: 38, offsetY: -46, scale: 0.93, widthPct: 79, heightPct: 105 },
    { width: 1023, offsetX: 56, offsetY: -48, scale: 0.93, widthPct: 79, heightPct: 105 },
    { width: 1050, offsetX: 35, offsetY: -48, scale: 0.93, widthPct: 78, heightPct: 105 },
    { width: 1085, offsetX: 40, offsetY: -48, scale: 0.93, widthPct: 78, heightPct: 105 },
    { width: 1110, offsetX: 45, offsetY: -48, scale: 0.93, widthPct: 78, heightPct: 105 },
    { width: 1150, offsetX: 51, offsetY: -48, scale: 0.93, widthPct: 78, heightPct: 105 },
    { width: 1250, offsetX: 59, offsetY: -48, scale: 0.93, widthPct: 78, heightPct: 105 },
    { width: 1314, offsetX: 67, offsetY: -48, scale: 0.93, widthPct: 78, heightPct: 105 },
    { width: 1745, offsetX: 72, offsetY: -48, scale: 0.93, widthPct: 78, heightPct: 105 },
  ],
};

const interpolateGridCalibration = (viewportWidth, mapType) => {
  const points = RESPONSIVE_GRID_CALIBRATION[mapType] || RESPONSIVE_GRID_CALIBRATION.TOWER;
  const width = Number(viewportWidth) || 1280;

  if (width <= points[0].width) {
    const { offsetX, offsetY, scale, widthPct, heightPct } = points[0];
    return { offsetX, offsetY, scale, widthPct, heightPct };
  }

  const last = points[points.length - 1];
  if (width >= last.width) {
    const { offsetX, offsetY, scale, widthPct, heightPct } = last;
    return { offsetX, offsetY, scale, widthPct, heightPct };
  }

  for (let index = 1; index < points.length; index += 1) {
    const right = points[index];
    const left = points[index - 1];

    if (width <= right.width) {
      const ratio = (width - left.width) / (right.width - left.width);
      const interpolate = (field) => left[field] + (right[field] - left[field]) * ratio;

      return {
        offsetX: Math.round(interpolate('offsetX')),
        offsetY: Math.round(interpolate('offsetY')),
        scale: Number(interpolate('scale').toFixed(3)),
        widthPct: Math.round(interpolate('widthPct')),
        heightPct: Math.round(interpolate('heightPct')),
      };
    }
  }

  const { offsetX, offsetY, scale, widthPct, heightPct } = last;
  return { offsetX, offsetY, scale, widthPct, heightPct };
};

const RESPONSIVE_TYPOGRAPHY_CSS = `
  .gvg-page { --gvg-font-scale: 1; }
  .gvg-page [class~="text-[8px]"] { font-size: calc(8px * var(--gvg-font-scale)) !important; }
  .gvg-page [class~="text-[9px]"] { font-size: calc(9px * var(--gvg-font-scale)) !important; }
  .gvg-page [class~="text-[10px]"] { font-size: calc(10px * var(--gvg-font-scale)) !important; }
  .gvg-page [class~="text-[11px]"] { font-size: calc(11px * var(--gvg-font-scale)) !important; }
  .gvg-page [class~="text-xs"] { font-size: calc(0.75rem * var(--gvg-font-scale)) !important; }
  .gvg-page [class~="text-sm"] { font-size: calc(0.875rem * var(--gvg-font-scale)) !important; }

  .gvg-map-node-arrow {
    width: clamp(9px, 1.5vw, 12px) !important;
    height: clamp(9px, 1.5vw, 12px) !important;
    font-size: clamp(7px, 1.1vw, 9px) !important;
  }
  .gvg-map-node-close {
    width: clamp(9px, 1.4vw, 11px) !important;
    height: clamp(9px, 1.4vw, 11px) !important;
    font-size: clamp(6px, 1vw, 8px) !important;
  }

  @media (max-width: 1280px) { .gvg-page { --gvg-font-scale: 0.96; } }
  @media (max-width: 1024px) { .gvg-page { --gvg-font-scale: 0.92; } }
  @media (max-width: 768px) { .gvg-page { --gvg-font-scale: 0.88; } }
  @media (max-width: 480px) { .gvg-page { --gvg-font-scale: 0.84; } }
`;

const ATTACK_DIRECTIONS = [
  { value: 'UP', arrow: '↑', angle: 0, position: 'left-1/2 top-2 -translate-x-1/2' },
  { value: 'RIGHT', arrow: '↑', angle: 90, position: 'right-1 top-1/2 -translate-y-1/2' },
  { value: 'DOWN', arrow: '↑', angle: 180, position: 'left-1/2 bottom-1 -translate-x-1/2' },
  { value: 'LEFT', arrow: '↑', angle: 270, position: 'left-1 top-1/2 -translate-y-1/2' },
];

const getDirection = (direction) =>
  ATTACK_DIRECTIONS.find((item) => item.value === direction) || ATTACK_DIRECTIONS[2];

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

const BATTLE_PRESET_DRAFT_STORAGE_KEY = 'gvg-battle-preset-draft';

const readBattlePresetDraft = () => {
  if (typeof window === 'undefined') return null;

  try {
    const raw = window.sessionStorage.getItem(BATTLE_PRESET_DRAFT_STORAGE_KEY);
    if (!raw) return null;

    const value = JSON.parse(raw);
    if (value?.source !== 'gvg-battle' || !Array.isArray(value.heroes)) return null;
    return value;
  } catch {
    return null;
  }
};

export default function GvgPage({ onBackToBattle }) {
  const [pendingBattleDraft, setPendingBattleDraft] = useState(() => readBattlePresetDraft());
  const [battleDraftApplied, setBattleDraftApplied] = useState(false);
  const [battleDraftSourceTitle, setBattleDraftSourceTitle] = useState('');
  const battleDraftApplyRef = useRef(false);
  const [mapType, setMapType] = useState(() => {
    const draft = readBattlePresetDraft();
    return draft?.mapType === 'FORT' ? 'FORT' : 'TOWER';
  });
  const [map, setMap] = useState(null);
  const [tiles, setTiles] = useState([]);
  const [heroes, setHeroes] = useState([]);

  const [presets, setPresets] = useState([]);
  const [openedPreset, setOpenedPreset] = useState(null);

  const [originalHeroIds, setOriginalHeroIds] = useState([]);
  const [originalSoldierIds, setOriginalSoldierIds] = useState([]);

  const [selectedHeroId, setSelectedHeroId] = useState(null);
  const [heroPlacements, setHeroPlacements] = useState({});

  const [attackCode, setAttackCode] = useState('');
  const [codeAvailability, setCodeAvailability] = useState({ status: 'idle', message: '' });
  const codeCheckSequence = useRef(0);
  const [attackName, setAttackName] = useState('');
  const [description, setDescription] = useState('');

  const [demonSoldiers, setDemonSoldiers] = useState([]);
  const [presetSoldiers, setPresetSoldiers] = useState([]);
  const [selectedDemonSoldierId, setSelectedDemonSoldierId] = useState('');
  const [demonSoldierLevel, setDemonSoldierLevel] = useState(1);
  const [isDemonSoldierDropdownOpen, setIsDemonSoldierDropdownOpen] = useState(false);
  const [demonSoldierSearchQuery, setDemonSoldierSearchQuery] = useState('');

  const [classFilter, setClassFilter] = useState('ALL');
  const [heroSearchQuery, setHeroSearchQuery] = useState('');
  const [sortBy, setSortBy] = useState('NAME');

  const [favoriteHeroIds, setFavoriteHeroIds] = useState(() => {
    if (typeof window === 'undefined') return [];
    try {
      const saved = localStorage.getItem(FAVORITES_STORAGE_KEY);
      return saved ? JSON.parse(saved) : [];
    } catch {
      return [];
    }
  });

  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [deletingPresetId, setDeletingPresetId] = useState(null);

  const [error, setError] = useState('');
  const [notice, setNotice] = useState('');

  const [viewportWidth, setViewportWidth] = useState(() =>
    typeof window !== 'undefined' ? window.innerWidth : 1280
  );

  const currentCalib = useMemo(
    () => interpolateGridCalibration(viewportWidth, mapType),
    [viewportWidth, mapType]
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

  const loadMap = useCallback(async (targetMapType) => {
    const typeToLoad = targetMapType || mapType;
    setLoading(true);
    setError('');

    try {
      const mapResponse = await api.get(`/gvg/maps/active?type=${typeToLoad}`);
      const activeMap = mapResponse.data;
      setMap(activeMap);

      const tilesResponse = await api.get(`/gvg/maps/${activeMap.id}/tiles`);
      setTiles(Array.isArray(tilesResponse.data) ? tilesResponse.data : []);
    } catch (err) {
      setMap(null);
      setTiles([]);
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

  // Завантажувати активну карту та її клітинки при відкритті сторінки
  // і при перемиканні між TOWER / FORT. Без цього loading залишатиметься true.
  useEffect(() => {
    loadMap(mapType);
  }, [mapType, loadMap]);

  // If navigation started in GvG War Room, import the current defense draft
  // once the corresponding map, tiles and hero catalogue have loaded.
  useEffect(() => {
    if (!pendingBattleDraft || battleDraftApplyRef.current) return;

    const requestedMapType = pendingBattleDraft.mapType === 'FORT' ? 'FORT' : 'TOWER';
    if (requestedMapType !== mapType) {
      setMapType(requestedMapType);
      return;
    }

    if (!map || !tiles.length || !heroes.length) return;

    const tileByCoordinates = new Map(tiles.map((tile) => [`${tile.x},${tile.y}`, tile]));
    const tileById = new Map(tiles.map((tile) => [String(tile.id), tile]));
    const heroesById = new Map(heroes.map((hero) => [String(hero.id), hero]));
    const restoredPlacements = {};
    const skippedHeroes = [];

    for (const placement of pendingBattleDraft.heroes) {
      if (placement?.heroId == null || placement?.tileId == null) continue;

      const hero = heroesById.get(String(placement.heroId));
      // Coordinates survive a map refresh/ID change; fallback to tileId only
      // when the active map is the same map as the source defense.
      const tile = tileByCoordinates.get(`${placement.x},${placement.y}`) ||
        (String(pendingBattleDraft.mapId) === String(map.id)
          ? tileById.get(String(placement.tileId))
          : null);

      if (!hero || !tile || tile.tileType === 'EMPTY') {
        skippedHeroes.push(placement.heroId);
        continue;
      }

      restoredPlacements[String(hero.id)] = {
        heroId: hero.id,
        tileId: tile.id,
        x: tile.x,
        y: tile.y,
        attackDirection: placement.attackDirection || 'DOWN',
      };
    }

    battleDraftApplyRef.current = true;

    if (Object.keys(restoredPlacements).length) {
      setOpenedPreset(null);
      setHeroPlacements(restoredPlacements);
      setSelectedHeroId(null);
      setOriginalHeroIds([]);
      setOriginalSoldierIds([]);
      setAttackCode('');
      setAttackName(pendingBattleDraft.suggestedName || `Контратака ${pendingBattleDraft.slotTitle || 'GvG'}`);
      setDescription('');
      setPresetSoldiers([]);
      setSelectedDemonSoldierId('');
      setDemonSoldierLevel(1);
      setNotice(`Перенесено ${Object.keys(restoredPlacements).length} героїв з розстановки ${pendingBattleDraft.slotTitle || 'GvG'}. Введи код нової атаки та збережи пресет.`);
      setBattleDraftApplied(true);
      setBattleDraftSourceTitle(pendingBattleDraft.slotTitle || 'GvG');

      if (skippedHeroes.length) {
        setError(`Не вдалося перенести героїв: ${skippedHeroes.join(', ')}. Перевір активну мапу та клітинки.`);
      }
    } else {
      setError('Не вдалося перенести розстановку з War Room: герої або клітинки не збіглися з активною мапою.');
    }

    try {
      window.sessionStorage.removeItem(BATTLE_PRESET_DRAFT_STORAGE_KEY);
    } catch {
      // Session storage may be unavailable in restricted browser contexts.
    }
    setPendingBattleDraft(null);
  }, [pendingBattleDraft, mapType, map, tiles, heroes]);

  useEffect(() => {
    const code = attackCode.trim();
    const excludePresetId = openedPreset?.preset?.id;

    if (!code) {
      setCodeAvailability({ status: 'idle', message: '' });
      return undefined;
    }

    if (code.length > 100) {
      setCodeAvailability({
        status: 'invalid',
        message: 'Код не може перевищувати 100 символів.',
      });
      return undefined;
    }

    const requestId = ++codeCheckSequence.current;
    setCodeAvailability({ status: 'checking', message: 'Перевіряємо код у базі гільдії…' });

    const timeoutId = setTimeout(async () => {
      try {
        const response = await api.get('/gvg/presets/code-availability', {
          params: {
            code,
            ...(excludePresetId ? { excludePresetId } : {}),
          },
        });

        if (requestId !== codeCheckSequence.current) return;

        if (response.data?.available) {
          setCodeAvailability({ status: 'available', message: 'Код вільний.' });
        } else {
          setCodeAvailability({
            status: 'taken',
            message: 'Такий код уже використовується в цій гільдії.',
          });
        }
      } catch (err) {
        if (requestId !== codeCheckSequence.current) return;
        setCodeAvailability({
          status: 'error',
          message: 'Не вдалося перевірити код. Перевірка повториться під час збереження.',
        });
      }
    }, 350);

    return () => {
      clearTimeout(timeoutId);
      codeCheckSequence.current += 1;
    };
  }, [attackCode, openedPreset?.preset?.id]);

  const toggleFavoriteHero = (heroId, event) => {
    event.stopPropagation();
    setFavoriteHeroIds((current) => {
      const updated = current.includes(heroId)
        ? current.filter((id) => id !== heroId)
        : [...current, heroId];

      try {
        localStorage.setItem(FAVORITES_STORAGE_KEY, JSON.stringify(updated));
      } catch (err) {
        console.error('Failed to save favorites to localStorage', err);
      }
      return updated;
    });
  };

  const tileLookup = useMemo(() => {
    const lookup = new Map();

    tiles.forEach((tile) => {
      lookup.set(`${tile.x},${tile.y}`, tile);
    });

    return lookup;
  }, [tiles]);

  const occupiedTileIds = useMemo(
    () => new Set(Object.values(heroPlacements).map((placement) => placement.tileId).filter(Boolean)),
    [heroPlacements]
  );

  const selectHero = (hero) => {
    setError('');
    setNotice('');

    setSelectedHeroId((current) => (current === hero.id ? null : hero.id));
  };

  const placeHero = (tile) => {
    if (!selectedHeroId) {
      setError('Спочатку вибери героя зі списку внизу.');
      return;
    }

    if (!tile || tile.tileType === 'EMPTY') return;

    const existingPlacement = heroPlacements[selectedHeroId];
    const currentPlacedCount = Object.keys(heroPlacements).length;

    if (!existingPlacement && currentPlacedCount >= MAX_HEROES_LIMIT) {
      setError(`Можна виставити максимум ${MAX_HEROES_LIMIT} героїв на мапу.`);
      return;
    }

    if (occupiedTileIds.has(tile.id) && existingPlacement?.tileId !== tile.id) {
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
        attackDirection: current[selectedHeroId]?.attackDirection || 'DOWN',
      },
    }));

    setError('');
    setNotice(`Героя розміщено на (${tile.x}, ${tile.y}).`);
  };

  const rotateHero = (heroId) => {
    setHeroPlacements((current) => {
      const placement = current[heroId];

      if (!placement) return current;

      const currentDirection = getDirection(placement.attackDirection);

      const currentIndex = ATTACK_DIRECTIONS.findIndex(
        (direction) => direction.value === currentDirection.value
      );

      const nextDirection = ATTACK_DIRECTIONS[(currentIndex + 1) % ATTACK_DIRECTIONS.length];

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

    const soldier = demonSoldiers.find((item) => String(item.id) === String(selectedDemonSoldierId));

    if (!soldier) {
      setError('Такого гвг солдата не знайдено.');
      return;
    }

    const level = Math.max(1, Number(demonSoldierLevel) || 1);

    setPresetSoldiers((current) => {
      const existingIndex = current.findIndex(
        (item) => String(item.soldierId) === String(soldier.id)
      );

      if (existingIndex >= 0) {
        const updated = [...current];
        updated[existingIndex] = {
          ...updated[existingIndex],
          level,
          demonSoldier: soldier,
        };
        return updated;
      }

      return [...current, { soldierId: soldier.id, level, demonSoldier: soldier }];
    });

    setSelectedDemonSoldierId('');
    setDemonSoldierLevel(1);
    setDemonSoldierSearchQuery('');
    setIsDemonSoldierDropdownOpen(false);
    setNotice(`Гвг солдата «${soldier.name}» додано до пресету.`);
  };

  const removePresetSoldier = (soldierId) => {
    setPresetSoldiers((current) =>
      current.filter((item) => String(item.soldierId) !== String(soldierId))
    );
  };

  const resetRecord = () => {
    setHeroPlacements({});
    setSelectedHeroId(null);
    setAttackCode('');
    setAttackName('');
    setDescription('');
    setPresetSoldiers([]);
    setSelectedDemonSoldierId('');
    setDemonSoldierLevel(1);
    setDemonSoldierSearchQuery('');
    setIsDemonSoldierDropdownOpen(false);
    setOpenedPreset(null);
    setOriginalHeroIds([]);
    setOriginalSoldierIds([]);
    setBattleDraftApplied(false);
    setBattleDraftSourceTitle('');
    setError('');
    setNotice('Запис скинуто.');
  };

  const clearHeroFilters = () => {
    setHeroSearchQuery('');
    setClassFilter('ALL');
  };

  const isEditingPreset = Boolean(openedPreset?.preset?.id);

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

    if (placements.length > MAX_HEROES_LIMIT) {
      setError(`Можна виставити максимум ${MAX_HEROES_LIMIT} героїв.`);
      return;
    }

    setSaving(true);

    try {
      // Повторно перевіряємо код безпосередньо перед збереженням, бо інший
      // учасник гільдії міг створити такий код, поки сторінка була відкрита.
      const availabilityResponse = await api.get('/gvg/presets/code-availability', {
        params: {
          code: attackCode.trim(),
          ...(isEditingPreset && openedPreset?.preset?.id
            ? { excludePresetId: openedPreset.preset.id }
            : {}),
        },
      });

      if (!availabilityResponse.data?.available) {
        setCodeAvailability({
          status: 'taken',
          message: 'Такий код уже використовується в цій гільдії.',
        });
        setError('Не можна зберегти пресет: цей код уже зайнятий. Введи інший код.');
        return;
      }

      setCodeAvailability({ status: 'available', message: 'Код вільний.' });

      if (isEditingPreset && openedPreset) {
        const presetId = openedPreset.preset.id;

        const presetResponse = await api.put(`/gvg/presets/${presetId}`, {
          presetCode: attackCode.trim(),
          name: attackName.trim(),
          description: description.trim() || null,
        });

        const preset = presetResponse.data;

        const currentHeroIds = new Set(placements.map((placement) => placement.heroId));
        const originalHeroIdsSet = new Set(originalHeroIds);

        const heroIdsToRemove = originalHeroIds.filter((heroId) => !currentHeroIds.has(heroId));
        for (const heroId of heroIdsToRemove) {
          await api.delete(`/gvg/presets/${presetId}/heroes/${heroId}`);
        }

        for (const placement of placements) {
          const heroData = {
            heroId: placement.heroId,
            tileId: placement.tileId,
            attackDirection: placement.attackDirection,
          };

          if (originalHeroIdsSet.has(placement.heroId)) {
            await api.put(`/gvg/presets/${presetId}/heroes/${placement.heroId}`, heroData);
          } else {
            await api.post(`/gvg/presets/${presetId}/heroes`, heroData);
          }
        }

        const currentSoldierIds = new Set(
          presetSoldiers.map((item) => String(item.soldierId))
        );
        const originalSoldierIdsSet = new Set(originalSoldierIds.map(String));

        const soldierIdsToRemove = originalSoldierIds.filter(
          (id) => !currentSoldierIds.has(String(id))
        );
        for (const soldierId of soldierIdsToRemove) {
          await api.delete(`/gvg/presets/${presetId}/soldiers/${soldierId}`);
        }

        for (const soldier of presetSoldiers) {
          const soldierData = {
            soldierId: soldier.soldierId,
            level: soldier.level,
          };

          if (originalSoldierIdsSet.has(String(soldier.soldierId))) {
            await api.put(
              `/gvg/presets/${presetId}/soldiers/${soldier.soldierId}`,
              soldierData
            );
          } else {
            await api.post(`/gvg/presets/${presetId}/soldiers`, soldierData);
          }
        }

        setNotice(`Журнал атаки «${preset.presetCode}» оновлено.`);
        setOriginalHeroIds(placements.map((placement) => placement.heroId));
        setOriginalSoldierIds(presetSoldiers.map((item) => item.soldierId));
      } else {
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
          await api.post(`/gvg/presets/${preset.id}/soldiers`, {
            soldierId: soldier.soldierId,
            level: soldier.level,
          });
        }

        setNotice(`Журнал атаки «${preset.presetCode}» записано.`);
        setOpenedPreset(null);
        setOriginalHeroIds([]);
        setOriginalSoldierIds([]);
      }

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
      const response = await api.get(`/gvg/presets/${presetId}/details`);
      const details = response.data;

      const targetMapType =
        details.map?.type ||
        details.preset?.mapType ||
        details.mapType ||
        (details.map?.name?.toUpperCase().includes('FORT') ? 'FORT' : null) ||
        (details.preset?.presetCode?.toLowerCase().includes('fort') ? 'FORT' : null) ||
        'TOWER';

      if (targetMapType && targetMapType !== mapType) {
        setMapType(targetMapType);
        await loadMap(targetMapType);
      }

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
      setOriginalHeroIds((details.heroes || []).map((hero) => hero.heroId));
      setSelectedHeroId(null);
      setAttackCode(details.preset?.presetCode || '');
      setAttackName(details.preset?.name || '');
      setDescription(details.preset?.description || '');

      try {
        const soldiersResponse = await api.get(`/gvg/presets/${presetId}/soldiers`);
        const assigned = Array.isArray(soldiersResponse.data) ? soldiersResponse.data : [];

        const normalized = assigned.map((item) => {
          const soldierId =
            item.soldierId ?? item.demonSoldierId ?? item.soldier?.id ?? item.demonSoldier?.id;
          const soldierData =
            item.soldier ||
            item.demonSoldier ||
            demonSoldiers.find((soldier) => String(soldier.id) === String(soldierId)) ||
            null;

          return {
            soldierId,
            level: item.level ?? soldierData?.level ?? 1,
            demonSoldier: soldierData,
          };
        });

        setPresetSoldiers(normalized);
        setOriginalSoldierIds(normalized.map((item) => item.soldierId));
      } catch {
        setPresetSoldiers([]);
        setOriginalSoldierIds([]);
      }

      setNotice(`Завантажено атаку «${details.preset?.presetCode}».`);
    } catch (err) {
      setError(errorMessage(err));
    }
  };

  const deletePreset = async (presetId, presetCode) => {
    if (typeof window !== 'undefined') {
      const confirmed = window.confirm(
        `Видалити пресет «${presetCode || presetId}»? Цю дію не можна скасувати.`
      );

      if (!confirmed) return;
    }

    setError('');
    setNotice('');
    setDeletingPresetId(presetId);

    try {
      await api.delete(`/gvg/presets/${presetId}`);

      if (openedPreset?.preset?.id === presetId) {
        resetRecord();
      }

      await loadPresets();
      setNotice('Пресет видалено.');
    } catch (err) {
      setError(errorMessage(err));
    } finally {
      setDeletingPresetId(null);
    }
  };

  const placedHeroes = useMemo(
    () =>
      Object.values(heroPlacements)
        .map((placement) => ({
          ...placement,
          hero: heroes.find((hero) => hero.id === placement.heroId),
        }))
        .filter((item) => Boolean(item.hero)),
    [heroPlacements, heroes]
  );

  const placedHeroesByTile = useMemo(
    () => new Map(placedHeroes.map((placement) => [placement.tileId, placement])),
    [placedHeroes]
  );

  const heroClasses = useMemo(
    () => [...new Set(heroes.map((hero) => hero.className).filter(Boolean))].sort(),
    [heroes]
  );

  const visibleHeroes = useMemo(() => {
    let list = heroes;

    if (classFilter !== 'ALL') {
      list = list.filter((hero) => hero.className === classFilter);
    }

    if (heroSearchQuery.trim()) {
      const query = heroSearchQuery.trim().toLowerCase();

      list = list.filter((hero) => hero.name?.toLowerCase().includes(query));
    }

    const favoriteSet = new Set(favoriteHeroIds);

    return [...list].sort((a, b) => {
      const isAFav = favoriteSet.has(a.id);
      const isBFav = favoriteSet.has(b.id);

      if (isAFav && !isBFav) return -1;
      if (!isAFav && isBFav) return 1;

      if (sortBy === 'CLASS') {
        return (
          (a.className || '').localeCompare(b.className || '') || (a.name || '').localeCompare(b.name || '')
        );
      }

      return (a.name || '').localeCompare(b.name || '');
    });
  }, [heroes, classFilter, heroSearchQuery, sortBy, favoriteHeroIds]);

  const selectedDemonSoldier = useMemo(
    () => demonSoldiers.find((soldier) => String(soldier.id) === String(selectedDemonSoldierId)) || null,
    [demonSoldiers, selectedDemonSoldierId]
  );

  const visibleDemonSoldiers = useMemo(() => {
    const query = demonSoldierSearchQuery.trim().toLowerCase();
    if (!query) return demonSoldiers;

    return demonSoldiers.filter((soldier) =>
      [soldier.name, soldier.rarity, soldier.faction].filter(Boolean).some((value) =>
        String(value).toLowerCase().includes(query)
      )
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

  if (loading) {
    return (
      <div className="gvg-page mx-auto max-w-7xl px-3 pt-1 md:px-0">
        <div className="rounded-2xl border border-surface-border bg-surface-raised p-6 text-center text-sm text-foreground-secondary shadow-surface">
          Завантаження GvG мапи…
        </div>
      </div>
    );
  }

  const currentDim = MAP_DIMENSIONS[mapType] || MAP_DIMENSIONS.FORT;

  return (
    <div className="gvg-page mx-auto max-w-7xl space-y-2 px-3 pt-1 text-foreground-primary md:px-0">
      <style>{RESPONSIVE_TYPOGRAPHY_CSS}</style>
      {battleDraftApplied ? (
        <div role="status" className="flex flex-col gap-2 rounded-xl border border-brand-success/30 bg-brand-success/10 p-3 text-xs text-brand-success-hover sm:flex-row sm:items-center sm:justify-between">
          <span>Розстановку з War Room ({battleDraftSourceTitle}) перенесено на карту. Перевір назву, введи код атаки та збережи пресет.</span>
         <button
           type="button"
           onClick={() => onBackToBattle?.()}
           className="inline-flex shrink-0 items-center justify-center rounded-lg border border-brand-success/40 px-3 py-1.5 font-bold transition hover:bg-brand-success/10"
         >
           ← Повернутися до War Room
         </button>
        </div>
      ) : null}
      {!map ? (
        <div className="rounded-2xl border border-dashed border-surface-border bg-surface-raised p-6 text-center text-sm text-foreground-secondary">
          Для цього типу зараз немає активної GvG мапи.
        </div>
      ) : (
        <div className="overflow-hidden rounded-2xl border border-surface-border bg-surface-raised shadow-surface">
          <div className="grid min-w-0 gap-0 lg:grid-cols-[minmax(0,1fr)_320px]">
            {/* Мапа */}
            <section className="relative flex min-w-0 flex-col justify-center border-b border-surface-border bg-surface-base p-2 pb-2 pt-12 lg:col-start-1 lg:row-start-1 lg:border-b-0 lg:border-r">
              <div className="absolute inset-x-0 top-0 z-30 flex items-start justify-between gap-3 bg-gradient-to-b from-surface-raised/95 to-transparent p-3">
                <div>
                  <h1 className="text-sm font-bold tracking-wide text-foreground-primary">
                    Enemy Defense Setup — {map.name}
                  </h1>
                  <p className="mt-0.5 text-[10px] text-foreground-muted">
                    Розстановка героїв на мапі ({Object.keys(heroPlacements).length}/{MAX_HEROES_LIMIT})
                  </p>
                </div>

                <span className="shrink-0 rounded-full border border-brand-success/30 bg-brand-success/10 px-2 py-1 text-[9px] font-bold uppercase tracking-wider text-brand-success-hover">
                  Активна мапа
                </span>
              </div>

              <div
                className="gvg-map-canvas relative isolate mx-auto my-0 block w-full min-w-0 max-w-[1000px] overflow-hidden rounded-xl border border-surface-border bg-surface-overlay shadow-surface"
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
                  draggable="false"
                  className="pointer-events-none absolute inset-0 block h-full w-full select-none object-contain"
                />

                <div
                  className="pointer-events-none absolute inset-8 flex min-w-0 items-center justify-center transition-transform duration-75"
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
                              placedHero && direction
                                ? `${placedHero.hero.name}, координати ${x}, ${y}. Напрямок: ${direction.value}. Клікни по зображенню для повороту стрілки.`
                                : `Клітинка ${x}, ${y}`
                            }
                            className={`relative flex h-full w-full items-center justify-center rounded-sm border transition-colors ${
                              placedHero
                                ? 'z-10 border border-surface-border/80 bg-surface-base/40 shadow-sm'
                                : isAvailableTarget
                                  ? 'z-10 animate-pulse border-brand-success/80 bg-brand-success/20 shadow-[0_0_8px_rgba(16,185,129,0.4)]'
                                  : 'border-surface-border/70 bg-surface-overlay/20 hover:border-brand-accent/60 hover:bg-brand-accent/20'
                            }`}
                            title={`X: ${x}, Y: ${y} · ${tile.tileType}`}
                          >
                            {placedHero && direction && (
                              <>
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
                                  {placedHero.hero?.imageSlug ? (
                                    <img
                                      src={`/images/heroes/${placedHero.hero.imageSlug}.png`}
                                      alt={placedHero.hero.name}
                                      draggable="false"
                                      className="h-full w-full select-none object-cover rounded-sm"
                                    />
                                  ) : (
                                    <div className="flex h-full w-full items-center justify-center bg-surface-sunken text-xs font-bold text-brand-accent">
                                      {placedHero.hero?.name?.charAt(0)}
                                    </div>
                                  )}

                                  <span
                                    aria-hidden="true"
                                    className={`pointer-events-none absolute gvg-map-node-arrow flex items-center justify-center rounded-full border border-surface-border bg-surface-raised/95 font-black leading-none text-brand-accent shadow-md transition-transform duration-150 ease-in-out ${direction.position}`}
                                    style={{
                                      transform: `rotate(${direction.angle}deg)`,
                                    }}
                                  >
                                    ↑
                                  </span>
                                </div>

                                <span
                                  className="pointer-events-none absolute -top-3 left-1/2 z-30 -translate-x-1/2 whitespace-nowrap rounded border border-surface-border bg-surface-sunken/95 font-bold text-foreground-primary shadow-surface px-1"
                                  style={{ fontSize: 'calc(7px * var(--gvg-font-scale))' }}
                                >
                                  {placedHero.hero?.name || 'Hero'}
                                </span>

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
                                  className="absolute -right-1 -top-1 z-40 flex gvg-map-node-close cursor-pointer items-center justify-center rounded-full border border-surface-border bg-surface-sunken font-black leading-none text-foreground-secondary shadow-md transition hover:scale-110 hover:bg-brand-danger hover:text-white focus-visible:outline-2 focus-visible:outline-offset-1 focus-visible:outline-brand-danger"
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

            {/* Каталог героїв */}
            <section className="min-w-0 border-t border-surface-border bg-surface-raised p-2 lg:col-span-2 lg:row-start-2">
              <div className="mb-2 flex flex-col gap-2 xl:flex-row xl:items-center xl:justify-between">
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
                    const isFavorite = favoriteHeroIds.includes(hero.id);
                    const placement = heroPlacements[hero.id];
                    const rarityRing = RARITY_RING[hero.rarity] || 'ring-gray-600';

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

                          <button
                            type="button"
                            onClick={(e) => toggleFavoriteHero(hero.id, e)}
                            aria-label={isFavorite ? 'Прибрати з обраних' : 'Додати в обрані'}
                            title={isFavorite ? 'В обраних' : 'Додати в обрані'}
                            className={`absolute -left-1 -top-1 flex h-5 w-5 items-center justify-center rounded-full border border-surface-raised transition-transform hover:scale-110 ${
                              isFavorite
                                ? 'bg-amber-400 text-black font-black'
                                : 'bg-surface-sunken/80 text-foreground-muted hover:text-amber-400'
                            }`}
                          >
                            ★
                          </button>

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
                  <span className="text-amber-400 font-bold">★</span>
                  Обраний герой (завжди зверху)
                </span>

                <span className="flex items-center gap-1.5">
                  <span className="flex h-3 w-3 items-center justify-center rounded-full bg-brand-danger text-[9px] font-bold text-white">
                    ×
                  </span>
                  Прибрати героя з мапи
                </span>
              </div>
            </section>

            {/* Бічна панель керування */}
            <aside className="flex min-w-0 flex-col gap-2 bg-surface-raised p-2 lg:col-start-2 lg:row-start-1">
              <div className="flex flex-wrap items-center justify-between gap-2 border-b border-surface-border pb-2">
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
              <div className="space-y-2 text-xs">
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
                    onChange={(event) => {
                      setAttackCode(event.target.value);
                      setError('');
                    }}
                    placeholder="Напр. f1-01"
                    maxLength={100}
                    autoComplete="off"
                    aria-describedby="attack-code-status"
                    aria-invalid={codeAvailability.status === 'taken' || codeAvailability.status === 'invalid'}
                    className={`${inputClass} ${
                      codeAvailability.status === 'taken' || codeAvailability.status === 'invalid'
                        ? 'border-brand-danger focus:border-brand-danger'
                        : codeAvailability.status === 'available'
                          ? 'border-brand-success focus:border-brand-success'
                          : ''
                    }`}
                  />
                  <p
                    id="attack-code-status"
                    role="status"
                    aria-live="polite"
                    className={`mt-1 min-h-4 text-[11px] ${
                      codeAvailability.status === 'available'
                        ? 'text-brand-success-hover'
                        : codeAvailability.status === 'taken' || codeAvailability.status === 'invalid'
                          ? 'text-brand-danger-hover'
                          : codeAvailability.status === 'checking'
                            ? 'text-foreground-muted'
                            : codeAvailability.status === 'error'
                              ? 'text-brand-accent-hover'
                              : 'text-transparent'
                    }`}
                  >
                    {codeAvailability.message || ' '}
                  </p>
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
                    rows={2}
                    className={`${inputClass} resize-y`}
                  />
                </div>

                {/* Призначення гвг солдатів пресету атаки */}
                <div className="space-y-1.5 rounded-lg border border-surface-border bg-surface-sunken/40 p-2">
                  <label className="block font-medium text-foreground-secondary">
                    Гвг солдати в пресеті · рівень
                  </label>

                  <div className="grid w-full min-w-0 grid-cols-[minmax(0,1fr)_3.25rem_4rem] items-center gap-1.5">
                    <div ref={demonSoldierDropdownRef} className="relative w-full min-w-0">
                      <button
                        type="button"
                        onClick={() => setIsDemonSoldierDropdownOpen((open) => !open)}
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
                      value={demonSoldierLevel}
                      onChange={(event) =>
                        setDemonSoldierLevel(event.target.value)
                      }
                      aria-label="Рівень солдата"
                      title="Рівень солдата"
                      placeholder="Рівень"
                      className={`${inputClass} h-11 w-full min-w-0 px-2 text-center`}
                    />

                    <button
                      type="button"
                      onClick={addPresetSoldier}
                      className="inline-flex min-h-11 w-full min-w-0 items-center justify-center whitespace-nowrap rounded-lg border border-surface-border bg-surface-sunken px-2 text-[10px] font-semibold text-foreground-secondary transition-colors hover:border-brand-accent/50 hover:bg-surface-raised hover:text-foreground-primary focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-accent disabled:cursor-not-allowed disabled:opacity-50"
                    >
                      Додати
                    </button>
                  </div>

                  {presetSoldiers.length === 0 ? (
                    <p className="text-[11px] text-foreground-muted">
                      Гвг солдатів ще не призначено.
                    </p>
                  ) : (
                    <ul className="space-y-1">
                      {presetSoldiers.map((item) => {
                        const soldierData =
                          item.demonSoldier ||
                          demonSoldiers.find((s) => String(s.id) === String(item.soldierId));
                        const rarityRing =
                          RARITY_RING[soldierData?.rarity] || 'ring-gray-600';

                        return (
                          <li
                            key={item.soldierId}
                            className="flex min-w-0 items-center justify-between gap-2 rounded-lg border border-surface-border bg-surface-base px-2 py-1.5 text-[11px]"
                          >
                            <div className="flex items-center gap-2 truncate">
                              <SoldierImage
                                soldier={soldierData}
                                className={`h-8 w-8 shrink-0 rounded-md ring-1 ${rarityRing}`}
                                fallbackClassName="text-[10px]"
                              />

                              <span className="truncate text-foreground-primary font-medium">
                                {soldierData?.name || `Солдат #${item.soldierId}`}
                                <span className="ml-1 text-foreground-muted font-normal">
                                  · рівень {item.level}
                                </span>
                              </span>
                            </div>

                            <button
                              type="button"
                              onClick={() =>
                                removePresetSoldier(item.soldierId)
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

                <div className="flex gap-2 pt-0">
                  <button
                    type="button"
                    onClick={savePreset}
                    disabled={saving || codeAvailability.status === 'taken' || codeAvailability.status === 'invalid'}
                    className={`${buttonPrimaryClass} flex-1`}
                  >
                    {saving ? 'Збереження…' : isEditingPreset ? 'Оновити пресет' : 'Зберегти'}
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

              {/* Список пресетів */}
              <div className="flex min-h-0 flex-1 flex-col border-t border-surface-border pt-2">
                <div className="mb-2 flex items-center justify-between gap-2">
                  <h3 className="text-xs font-bold text-foreground-secondary">
                    Збережені пресети
                  </h3>

                  <span className="rounded-full border border-surface-border bg-surface-sunken px-2 py-0.5 text-[10px] font-semibold text-foreground-muted">
                    {presets.length}
                  </span>
                </div>

                <div className="max-h-[140px] space-y-1 overflow-y-auto overscroll-contain pr-1">
                  {presets.length === 0 ? (
                    <p className="rounded-lg border border-dashed border-surface-border px-3 py-4 text-center text-xs text-foreground-muted">
                      Збережених пресетів поки немає.
                    </p>
                  ) : (
                    presets.map((preset) => {
                      const isOpened =
                        openedPreset?.preset?.id === preset.id;
                      const isDeleting = deletingPresetId === preset.id;

                      return (
                        <div
                          key={preset.id}
                          className={`flex items-center justify-between gap-2 rounded-lg border p-2 transition-colors ${
                            isOpened
                              ? 'border-brand-accent bg-brand-accent/10'
                              : 'border-surface-border bg-surface-base hover:border-brand-accent/40 hover:bg-surface-sunken'
                          }`}
                        >
                          <button
                            type="button"
                            onClick={() => openPreset(preset.id)}
                            aria-pressed={isOpened}
                            className="min-w-0 flex-1 text-left outline-none focus-visible:outline-2 focus-visible:outline-offset-1 focus-visible:outline-brand-accent"
                          >
                            <div
                              className="max-w-full truncate font-mono text-xs font-bold text-brand-accent"
                              title={preset.presetCode}
                            >
                              {preset.presetCode}
                            </div>
                            <div className="mt-0.5 truncate text-[11px] text-foreground-secondary">
                              {preset.name}
                            </div>
                          </button>

                          <button
                            type="button"
                            disabled={isDeleting}
                            onClick={() => deletePreset(preset.id, preset.presetCode)}
                            aria-label={`Видалити пресет ${preset.presetCode}`}
                            title="Видалити пресет"
                            className="flex h-6 w-6 shrink-0 items-center justify-center rounded-md border border-brand-danger/30 bg-brand-danger/10 text-xs font-bold text-brand-danger-hover transition-colors hover:bg-brand-danger/20 disabled:opacity-50"
                          >
                            {isDeleting ? '…' : '×'}
                          </button>
                        </div>
                      );
                    })
                  )}
                </div>
              </div>
            </aside>
          </div>
        </div>
      )}
    </div>
  );
}
