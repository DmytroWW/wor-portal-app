import { useEffect, useMemo, useRef, useState } from 'react';
import api from '../../api/axios';

const MAP_TYPES = [
  { value: 'FORT', label: 'Fort' },
  { value: 'TOWER', label: 'Tower' },
];

const MAX_HEROES = 5;
const FAVORITES_STORAGE_KEY = 'gvg_favorite_hero_ids';

const RARITY_RING = {
  Common: 'ring-gray-400',
  Uncommon: 'ring-green-400',
  Rare: 'ring-blue-400',
  Epic: 'ring-purple-400',
  Legendary: 'ring-amber-400',
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
  'w-full min-w-0 rounded-lg border border-surface-border bg-surface-sunken px-3 py-1.5 text-xs text-foreground-primary outline-none transition-colors placeholder:text-foreground-muted/70 focus:border-brand-accent disabled:cursor-not-allowed disabled:opacity-50';

const buttonSecondaryClass =
  'inline-flex items-center justify-center gap-1 rounded-lg border border-surface-border bg-surface-sunken px-2.5 py-1.5 text-[10px] font-semibold text-foreground-secondary transition-colors hover:border-brand-accent/50 hover:bg-surface-raised hover:text-foreground-primary focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-accent disabled:cursor-not-allowed disabled:opacity-50';

const buttonPrimaryClass =
  'inline-flex items-center justify-center gap-1 rounded-lg bg-brand-accent px-3 py-1.5 text-[10px] font-bold text-foreground-onAccent shadow-brand-accent transition-colors hover:bg-brand-accent-hover focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-accent disabled:cursor-not-allowed disabled:opacity-50';

const readFavoriteHeroIds = () => {
  if (typeof window === 'undefined') return [];

  try {
    const saved = window.localStorage.getItem(FAVORITES_STORAGE_KEY);
    const parsed = saved ? JSON.parse(saved) : [];

    return Array.isArray(parsed)
      ? [...new Set(parsed.filter((id) => id != null).map(String))]
      : [];
  } catch {
    return [];
  }
};

const getRarityRing = (rarity) => {
  const value = String(rarity || '').trim().toLowerCase();
  const normalized = value ? value[0].toUpperCase() + value.slice(1) : '';
  return RARITY_RING[normalized] || 'ring-gray-600';
};

const getPresetMapType = (details) => {
  const value = String(
    details?.map?.mapType ||
    details?.map?.type ||
    details?.map?.name ||
    ''
  ).toUpperCase();

  if (value.includes('FORT')) return 'FORT';
  if (value.includes('TOWER')) return 'TOWER';

  return 'TOWER';
};

const isHeroCompatible = (hero, tile) => {
  if (!hero || !tile || tile.tileType === 'EMPTY') return false;

  const heroClass = String(hero.className || '').toUpperCase();

  if (['DEFENDER', 'FIGHTER'].includes(heroClass)) {
    return tile.tileType === 'GROUND';
  }

  if (['MARKSMAN', 'MAGE', 'HEALER'].includes(heroClass)) {
    return tile.tileType === 'PLATFORM';
  }

  if (heroClass === 'TACTICIAN') {
    return ['GROUND', 'PLATFORM'].includes(tile.tileType);
  }

  return false;
};

const HeroPortrait = ({ hero, className = '' }) => {
  const fallback = hero?.name?.trim()?.charAt(0)?.toUpperCase() || '?';

  return (
    <div className={`relative overflow-hidden bg-surface-overlay ${className}`}>
      {hero?.imageSlug ? (
        <img
          src={`/images/heroes/${hero.imageSlug}.png`}
          alt={hero.name || 'Герой'}
          draggable="false"
          className="h-full w-full select-none object-cover"
          onError={(event) => {
            event.currentTarget.style.display = 'none';
            event.currentTarget.nextElementSibling?.classList.remove('hidden');
          }}
        />
      ) : null}

      <div
        className={`${hero?.imageSlug ? 'hidden ' : ''}absolute inset-0 flex items-center justify-center bg-surface-sunken text-xs font-bold text-brand-accent`}
        aria-hidden="true"
      >
        {fallback}
      </div>
    </div>
  );
};

export default function GvgSearchPresetPage() {
  const [mapType, setMapType] = useState('TOWER');
  const [map, setMap] = useState(null);
  const [tiles, setTiles] = useState([]);
  const [heroes, setHeroes] = useState([]);

  const [heroPlacements, setHeroPlacements] = useState({});
  const [selectedHeroId, setSelectedHeroId] = useState(null);

  const [heroSearchQuery, setHeroSearchQuery] = useState('');
  const [classFilter, setClassFilter] = useState('ALL');
  const [sortBy, setSortBy] = useState('NAME');

  const [favoriteHeroIds, setFavoriteHeroIds] = useState(readFavoriteHeroIds);

  const [results, setResults] = useState([]);
  const [resultDetails, setResultDetails] = useState({});
  const [hasSearched, setHasSearched] = useState(false);

  const [openedPreset, setOpenedPreset] = useState(null);
  const [previewMap, setPreviewMap] = useState(null);
  const [previewTiles, setPreviewTiles] = useState([]);

  const [loadingMap, setLoadingMap] = useState(true);
  const [loadingHeroes, setLoadingHeroes] = useState(true);
  const [searching, setSearching] = useState(false);
  const [loadingDetails, setLoadingDetails] = useState(false);

  const [error, setError] = useState('');
  const [notice, setNotice] = useState('');
  const [copiedPresetId, setCopiedPresetId] = useState(null);

  const [viewportWidth, setViewportWidth] = useState(() =>
    typeof window !== 'undefined' ? window.innerWidth : 1280
  );

  const heroListRef = useRef(null);
  const searchRequestRef = useRef(0);
  const detailsRequestRef = useRef(0);
  const mapRequestRef = useRef(0);

  const isPreview = Boolean(openedPreset);
  const displayedMap = isPreview ? previewMap : map;
  const displayedTiles = isPreview ? previewTiles : tiles;
  const displayedMapType = isPreview ? getPresetMapType(openedPreset) : mapType;

  const currentCalib = useMemo(
    () => interpolateGridCalibration(viewportWidth, displayedMapType),
    [viewportWidth, displayedMapType]
  );

  useEffect(() => {
    const handleResize = () => setViewportWidth(window.innerWidth);
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);

  useEffect(() => {
    let active = true;

    const loadHeroes = async () => {
      try {
        const response = await api.get('/heroes');
        if (active) setHeroes(Array.isArray(response.data) ? response.data : []);
      } catch (err) {
        if (active) setError(errorMessage(err));
      } finally {
        if (active) setLoadingHeroes(false);
      }
    };

    loadHeroes();

    return () => {
      active = false;
    };
  }, []);

  useEffect(() => {
    const requestId = ++mapRequestRef.current;
    let active = true;

    const loadMap = async () => {
      setLoadingMap(true);
      setMap(null);
      setTiles([]);
      setError('');

      try {
        const mapResponse = await api.get(`/gvg/maps/active?type=${mapType}`);
        const targetMap = mapResponse.data;

        if (!targetMap?.id) {
          throw new Error(`Для ${mapType} немає активної карти.`);
        }

        const tilesResponse = await api.get(`/gvg/maps/${targetMap.id}/tiles`);

        if (!active || requestId !== mapRequestRef.current) return;

        setMap(targetMap);
        setTiles(Array.isArray(tilesResponse.data) ? tilesResponse.data : []);
      } catch (err) {
        if (active && requestId === mapRequestRef.current) {
          setError(errorMessage(err));
        }
      } finally {
        if (active && requestId === mapRequestRef.current) {
          setLoadingMap(false);
        }
      }
    };

    loadMap();

    return () => {
      active = false;
    };
  }, [mapType]);

  const heroesById = useMemo(
    () => new Map(heroes.map((hero) => [String(hero.id), hero])),
    [heroes]
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

    const favorites = new Set(favoriteHeroIds);

    return [...list].sort((a, b) => {
      const aFav = favorites.has(String(a.id));
      const bFav = favorites.has(String(b.id));

      if (aFav !== bFav) return aFav ? -1 : 1;

      if (sortBy === 'CLASS') {
        return (
          (a.className || '').localeCompare(b.className || '') ||
          (a.name || '').localeCompare(b.name || '')
        );
      }

      return (a.name || '').localeCompare(b.name || '');
    });
  }, [heroes, classFilter, heroSearchQuery, sortBy, favoriteHeroIds]);

  const searchPlacements = useMemo(
    () => Object.values(heroPlacements),
    [heroPlacements]
  );

  const displayedPlacements = useMemo(() => {
    if (isPreview) return openedPreset?.heroes || [];
    return searchPlacements;
  }, [isPreview, openedPreset, searchPlacements]);

  const tileLookup = useMemo(
    () => new Map(displayedTiles.map((tile) => [`${tile.x},${tile.y}`, tile])),
    [displayedTiles]
  );

  const placementsByTile = useMemo(
    () =>
      new Map(
        displayedPlacements
          .filter((placement) => placement.tileId != null)
          .map((placement) => [String(placement.tileId), placement])
      ),
    [displayedPlacements]
  );

  const occupiedTileIds = useMemo(
    () => new Set(searchPlacements.map((placement) => String(placement.tileId))),
    [searchPlacements]
  );

  const invalidateSearch = () => {
    searchRequestRef.current += 1;
    setSearching(false);
    setResults([]);
    setResultDetails({});
    setHasSearched(false);
  };

  const closePreview = () => {
    detailsRequestRef.current += 1;
    setOpenedPreset(null);
    setPreviewMap(null);
    setPreviewTiles([]);
    setLoadingDetails(false);
  };

  const resetPlacements = () => {
    invalidateSearch();
    closePreview();
    setHeroPlacements({});
    setSelectedHeroId(null);
    setError('');
    setNotice('Розстановку очищено.');
  };

  const changeMapType = (type) => {
    if (type === mapType && !isPreview) return;

    resetPlacements();
    setMapType(type);
  };

  const toggleFavoriteHero = (heroId, event) => {
    event.stopPropagation();

    const id = String(heroId);

    setFavoriteHeroIds((current) => {
      const updated = current.includes(id)
        ? current.filter((item) => item !== id)
        : [...current, id];

      try {
        window.localStorage.setItem(FAVORITES_STORAGE_KEY, JSON.stringify(updated));
      } catch {
        // Storage may be unavailable.
      }

      return updated;
    });
  };

  const selectHero = (hero) => {
    if (isPreview) return;

    setSelectedHeroId((current) =>
      String(current) === String(hero.id) ? null : hero.id
    );

    setError('');
    setNotice('');
  };

  const placeHero = (tile) => {
    if (isPreview) return;

    if (!selectedHeroId) {
      setNotice('Спочатку вибери героя в каталозі.');
      return;
    }

    const hero = heroesById.get(String(selectedHeroId));

    if (!isHeroCompatible(hero, tile)) {
      setNotice(`Герой ${hero?.name || ''} не може стояти на цій клітинці.`);
      return;
    }

    const existing = heroPlacements[selectedHeroId];

    if (!existing && searchPlacements.length >= MAX_HEROES) {
      setNotice(`Можна розмістити максимум ${MAX_HEROES} героїв.`);
      return;
    }

    if (
      occupiedTileIds.has(String(tile.id)) &&
      String(existing?.tileId) !== String(tile.id)
    ) {
      setNotice('Ця клітинка вже зайнята.');
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

    invalidateSearch();
    setError('');
    setNotice('');
  };

  const rotateHero = (heroId) => {
    setHeroPlacements((current) => {
      const placement = current[heroId];
      if (!placement) return current;

      const index = ATTACK_DIRECTIONS.findIndex(
        (item) => item.value === placement.attackDirection
      );

      const next = ATTACK_DIRECTIONS[(index + 1) % ATTACK_DIRECTIONS.length];

      return {
        ...current,
        [heroId]: {
          ...placement,
          attackDirection: next.value,
        },
      };
    });

    invalidateSearch();
    setError('');
    setNotice('');
  };

  const removeHeroFromMap = (heroId) => {
    setHeroPlacements((current) => {
      const updated = { ...current };
      delete updated[heroId];
      return updated;
    });

    if (String(selectedHeroId) === String(heroId)) {
      setSelectedHeroId(null);
    }

    invalidateSearch();
    setError('');
    setNotice('');
  };

  const searchPresets = async () => {
    if (!map?.id || searchPlacements.length !== MAX_HEROES || searching) return;

    const requestId = ++searchRequestRef.current;

    setSearching(true);
    setHasSearched(false);
    setError('');
    setNotice('');
    setResults([]);
    setResultDetails({});

    try {
      const response = await api.post('/gvg/presets/search', {
        mapId: map.id,
        heroes: searchPlacements.map((placement) => ({
          heroId: placement.heroId,
          tileId: placement.tileId,
          attackDirection: placement.attackDirection,
        })),
      });

      if (requestId !== searchRequestRef.current) return;

      const found = Array.isArray(response.data) ? response.data : [];

      setResults(found);
      setHasSearched(true);

      setNotice(
        found.length
          ? `Знайдено ${found.length} пресетів із точним збігом.`
          : 'Пресетів зі 100% збігом не знайдено.'
      );

      if (found.length > 0) {
        const detailResults = await Promise.all(
          found.map(async (preset) => {
            try {
              const detailResponse = await api.get(`/gvg/presets/${preset.id}/details`);
              return [String(preset.id), detailResponse.data];
            } catch {
              return [String(preset.id), null];
            }
          })
        );

        if (requestId !== searchRequestRef.current) return;

        setResultDetails(Object.fromEntries(detailResults));
      }
    } catch (err) {
      if (requestId === searchRequestRef.current) {
        setError(errorMessage(err));
      }
    } finally {
      if (requestId === searchRequestRef.current) {
        setSearching(false);
      }
    }
  };

  const openPreset = async (preset) => {
    const requestId = ++detailsRequestRef.current;

    setLoadingDetails(true);
    setError('');

    try {
      let details = resultDetails[String(preset.id)];

      if (!details) {
        const response = await api.get(`/gvg/presets/${preset.id}/details`);
        details = response.data;
      }

      if (requestId !== detailsRequestRef.current) return;

      const presetMap = details?.map;

      if (!presetMap?.id) {
        throw new Error('Карта пресету недоступна.');
      }

      const tilesResponse = await api.get(`/gvg/maps/${presetMap.id}/tiles`);

      if (requestId !== detailsRequestRef.current) return;

      setOpenedPreset(details);
      setPreviewMap(presetMap);
      setPreviewTiles(Array.isArray(tilesResponse.data) ? tilesResponse.data : []);
      setNotice(`Відкрито пресет «${preset.name || preset.presetCode}».`);
    } catch (err) {
      if (requestId === detailsRequestRef.current) {
        setError(errorMessage(err));
      }
    } finally {
      if (requestId === detailsRequestRef.current) {
        setLoadingDetails(false);
      }
    }
  };

  const copyPresetCode = async (preset) => {
    try {
      await navigator.clipboard.writeText(String(preset.presetCode || ''));

      setCopiedPresetId(preset.id);
      setNotice(`Код «${preset.presetCode}» скопійовано.`);

      window.setTimeout(() => {
        setCopiedPresetId((current) => (current === preset.id ? null : current));
      }, 1800);
    } catch {
      setError('Не вдалося скопіювати код пресету.');
    }
  };

  const scrollHeroList = (direction) => {
    heroListRef.current?.scrollBy({
      left: direction * 260,
      behavior: 'smooth',
    });
  };

  const clearHeroFilters = () => {
    setHeroSearchQuery('');
    setClassFilter('ALL');
  };

  const currentDim = MAP_DIMENSIONS[displayedMapType] || MAP_DIMENSIONS.TOWER;

  return (
    <div className="gvg-page mx-auto max-w-7xl space-y-2 px-3 pt-1 text-foreground-primary md:px-0">
      <style>{RESPONSIVE_TYPOGRAPHY_CSS}</style>

      <div className="overflow-hidden rounded-2xl border border-surface-border bg-surface-raised shadow-surface">
        <div className="grid min-w-0 gap-0 lg:grid-cols-[minmax(0,1fr)_320px]">

          {/* MAP */}
          <section className="relative order-1 flex min-w-0 flex-col justify-center border-b border-surface-border bg-surface-base p-2 pb-2 pt-12 lg:col-start-1 lg:row-start-1 lg:border-b-0 lg:border-r">
            <div className="absolute inset-x-0 top-0 z-30 flex items-start justify-between gap-3 bg-gradient-to-b from-surface-raised/95 to-transparent p-3">
              <div className="min-w-0">
                <h1 className="truncate text-sm font-bold tracking-wide">
                  {isPreview
                    ? openedPreset?.preset?.name || openedPreset?.preset?.presetCode
                    : `Enemy Defense Setup — ${map?.name || mapType}`}
                </h1>

                <p className="mt-0.5 text-[10px] text-foreground-muted">
                  {isPreview
                    ? `Код: ${openedPreset?.preset?.presetCode}`
                    : `Розстановка героїв на мапі (${searchPlacements.length}/${MAX_HEROES})`}
                </p>
              </div>

              <span className="shrink-0 rounded-full border border-brand-success/30 bg-brand-success/10 px-2 py-1 text-[9px] font-bold uppercase tracking-wider text-brand-success-hover">
                {isPreview ? 'Перегляд пресету' : loadingMap ? 'Завантаження…' : 'Активна мапа'}
              </span>
            </div>

            {displayedMap ? (
              <div
                className="gvg-map-canvas relative isolate mx-auto my-0 block w-full min-w-0 max-w-[1000px] overflow-hidden rounded-xl border border-surface-border bg-surface-overlay shadow-surface"
                style={{
                  aspectRatio: `${currentDim.width} / ${currentDim.height}`,
                }}
              >
                <img
                  src={
                    displayedMapType === 'FORT'
                      ? '/images/maps/fort-bg.png'
                      : '/images/maps/tower-bg.png'
                  }
                  alt={displayedMap.name || displayedMapType}
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
                      gridTemplateColumns: `repeat(${displayedMap.width}, minmax(0, 1fr))`,
                      gridTemplateRows: `repeat(${displayedMap.height}, minmax(0, 1fr))`,
                      gap: '2px',
                    }}
                  >
                    {Array.from({ length: displayedMap.height }, (_, y) =>
                      Array.from({ length: displayedMap.width }, (_, x) => {
                        const tile = tileLookup.get(`${x},${y}`);

                        if (!tile || tile.tileType === 'EMPTY') {
                          return <div key={`${x}-${y}`} />;
                        }

                        const placement = placementsByTile.get(String(tile.id));
                        const hero = placement
                          ? heroesById.get(String(placement.heroId))
                          : null;

                        const direction = placement
                          ? getDirection(placement.attackDirection)
                          : null;

                        const isOccupied = occupiedTileIds.has(String(tile.id));
                        const isAvailableTarget =
                          !isPreview && selectedHeroId && !isOccupied;

                        return (
                          <div
                            key={`${x}-${y}`}
                            className={`relative flex h-full w-full items-center justify-center rounded-sm border transition-colors ${
                              placement
                                ? 'z-10 border-surface-border/80 bg-surface-base/40 shadow-sm'
                                : isAvailableTarget
                                ? 'z-10 animate-pulse border-brand-success/80 bg-brand-success/20 shadow-[0_0_8px_rgba(16,185,129,0.4)]'
                                : 'border-surface-border/70 bg-surface-overlay/20'
                            }`}
                          >
                            {!placement && !isPreview && (
                              <button
                                type="button"
                                onClick={() => placeHero(tile)}
                                className="absolute inset-0 h-full w-full hover:bg-brand-accent/20"
                                aria-label={`Клітинка ${x}, ${y}`}
                                title={`X: ${x}, Y: ${y} · ${tile.tileType}`}
                              />
                            )}

                            {placement && direction && (
                              <>
                                {isPreview ? (
                                  <div className="absolute inset-0.5 z-10 rounded-sm">
                                    <HeroPortrait
                                      hero={hero}
                                      className="h-full w-full rounded-sm"
                                    />
                                    <span
                                      aria-hidden="true"
                                      className={`pointer-events-none absolute gvg-map-node-arrow flex items-center justify-center rounded-full border border-surface-border bg-surface-raised/95 font-black leading-none text-brand-accent shadow-md ${direction.position}`}
                                      style={{ transform: `rotate(${direction.angle}deg)` }}
                                    >
                                      ↑
                                    </span>
                                  </div>
                                ) : (
                                  <button
                                    type="button"
                                    onClick={() => rotateHero(placement.heroId)}
                                    aria-label={`Повернути напрямок героя ${hero?.name || ''}`}
                                    title={`Напрямок: ${direction.value}. Натисни для повороту`}
                                    className="absolute inset-0.5 z-10 cursor-pointer rounded-sm focus-visible:outline-2 focus-visible:outline-brand-accent"
                                  >
                                    <HeroPortrait
                                      hero={hero}
                                      className="h-full w-full rounded-sm"
                                    />

                                    <span
                                      aria-hidden="true"
                                      className={`pointer-events-none absolute gvg-map-node-arrow flex items-center justify-center rounded-full border border-surface-border bg-surface-raised/95 font-black leading-none text-brand-accent shadow-md ${direction.position}`}
                                      style={{ transform: `rotate(${direction.angle}deg)` }}
                                    >
                                      ↑
                                    </span>
                                  </button>
                                )}

                                <span
                                  className="pointer-events-none absolute -top-3 left-1/2 z-30 -translate-x-1/2 whitespace-nowrap rounded border border-surface-border bg-surface-sunken/95 px-1 font-bold text-foreground-primary shadow-surface"
                                  style={{ fontSize: 'calc(7px * var(--gvg-font-scale))' }}
                                >
                                  {hero?.name || 'Hero'}
                                </span>

                                {!isPreview && (
                                  <button
                                    type="button"
                                    onClick={() => removeHeroFromMap(placement.heroId)}
                                    aria-label={`Прибрати ${hero?.name || 'героя'} з мапи`}
                                    title="Прибрати героя"
                                    className="gvg-map-node-close absolute -right-1 -top-1 z-40 flex cursor-pointer items-center justify-center rounded-full border border-surface-border bg-surface-sunken font-black leading-none text-foreground-secondary shadow-md transition hover:scale-110 hover:bg-brand-danger hover:text-white"
                                  >
                                    ×
                                  </button>
                                )}
                              </>
                            )}
                          </div>
                        );
                      })
                    )}
                  </div>
                </div>
              </div>
            ) : (
              <div className="flex aspect-video w-full items-center justify-center rounded-xl border border-dashed border-surface-border bg-surface-overlay p-4 text-center text-xs text-foreground-muted">
                {loadingMap ? 'Завантаження мапи…' : 'Мапа недоступна.'}
              </div>
            )}

            <p className="mt-2 text-center text-[10px] text-foreground-muted">
              {isPreview
                ? 'Перегляд знайденого пресету. Повернися до пошуку, щоб змінити розстановку.'
                : selectedHeroId
                ? 'Вибери клітинку для розміщення героя. Натисни на героя на мапі, щоб повернути його.'
                : 'Вибери героя в каталозі. Натисни на героя на мапі, щоб повернути стрілку напрямку.'}
            </p>
          </section>

          {/* HERO CATALOG */}
          <section className="order-2 min-w-0 border-t border-surface-border bg-surface-raised p-2 lg:col-span-2 lg:row-start-2">
            <div className="mb-2 flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
              <div className="flex flex-wrap items-center gap-2">
                <h3 className="text-xs font-bold uppercase tracking-wider text-brand-accent">
                  Каталог героїв
                </h3>

                <span className="rounded-full border border-surface-border bg-surface-sunken px-2 py-0.5 text-[10px] font-semibold text-foreground-muted">
                  {visibleHeroes.length}
                </span>

                {selectedHeroId && !isPreview && (
                  <span className="rounded-full border border-brand-success/30 bg-brand-success/10 px-2 py-0.5 text-[10px] font-semibold text-brand-success-hover">
                    Герой вибраний
                  </span>
                )}
              </div>

              <div className="flex flex-wrap items-center gap-1.5">
                <div className="relative w-full sm:w-36">
                  <input
                    type="text"
                    value={heroSearchQuery}
                    onChange={(event) => setHeroSearchQuery(event.target.value)}
                    placeholder="Пошук героя…"
                    className={`${inputClass} pr-7`}
                  />

                  {(heroSearchQuery || classFilter !== 'ALL') && (
                    <button
                      type="button"
                      onClick={clearHeroFilters}
                      aria-label="Очистити фільтри"
                      className="absolute right-1 top-1/2 flex h-6 w-6 -translate-y-1/2 items-center justify-center rounded text-sm font-bold text-brand-danger hover:bg-brand-danger/10"
                    >
                      ×
                    </button>
                  )}
                </div>

                <select
                  value={classFilter}
                  onChange={(event) => setClassFilter(event.target.value)}
                  aria-label="Фільтр за класом"
                  className={`${inputClass} w-auto`}
                >
                  <option value="ALL">Усі класи</option>
                  {heroClasses.map((heroClass) => (
                    <option key={heroClass} value={heroClass}>
                      {heroClass}
                    </option>
                  ))}
                </select>

                <select
                  value={sortBy}
                  onChange={(event) => setSortBy(event.target.value)}
                  aria-label="Сортування героїв"
                  className={`${inputClass} w-auto`}
                >
                  <option value="NAME">За ім'ям</option>
                  <option value="CLASS">За класом</option>
                </select>

                <button
                  type="button"
                  onClick={() => scrollHeroList(-1)}
                  aria-label="Прокрутити ліворуч"
                  className={buttonSecondaryClass}
                >
                  ←
                </button>

                <button
                  type="button"
                  onClick={() => scrollHeroList(1)}
                  aria-label="Прокрутити праворуч"
                  className={buttonSecondaryClass}
                >
                  →
                </button>
              </div>
            </div>

            {loadingHeroes ? (
              <div className="p-4 text-center text-xs text-foreground-muted">
                Завантаження героїв…
              </div>
            ) : visibleHeroes.length === 0 ? (
              <div className="rounded-lg border border-dashed border-surface-border p-4 text-center text-xs text-foreground-muted">
                Героїв не знайдено.
              </div>
            ) : (
              <div
                ref={heroListRef}
                className="flex gap-2 overflow-x-auto overscroll-x-contain pb-2"
              >
                {visibleHeroes.map((hero) => {
                  const selected = String(selectedHeroId) === String(hero.id);
                  const placement = heroPlacements[hero.id];
                  const favorite = favoriteHeroIds.includes(String(hero.id));

                  return (
                    <div
                      key={hero.id}
                      className={`group relative w-[76px] flex-shrink-0 rounded-lg border p-1.5 transition-colors ${
                        selected && !isPreview
                          ? 'border-brand-accent bg-brand-accent/10'
                          : placement
                          ? 'border-brand-success/50 bg-brand-success/5'
                          : 'border-surface-border bg-surface-base hover:border-brand-accent/40'
                      }`}
                    >
                      <button
                        type="button"
                        disabled={isPreview}
                        onClick={() => selectHero(hero)}
                        aria-pressed={selected}
                        className="block w-full text-center disabled:cursor-default"
                      >
                        <div
                          className={`relative mx-auto h-12 w-12 rounded-md ring-2 ${getRarityRing(
                            hero.rarity
                          )}`}
                        >
                          <HeroPortrait hero={hero} className="h-full w-full rounded-md" />

                          {placement && (
                            <span className="absolute -right-1 -top-1 flex h-4 w-4 items-center justify-center rounded-full border border-surface-raised bg-brand-success text-[9px] font-bold text-white">
                              ✓
                            </span>
                          )}
                        </div>

                        <p className="mt-1.5 truncate text-[9px] font-bold">
                          {hero.name}
                        </p>

                        <p className="truncate text-[8px] text-foreground-muted">
                          {hero.className || 'Hero'}
                        </p>
                      </button>

                      <button
                        type="button"
                        onClick={(event) => toggleFavoriteHero(hero.id, event)}
                        aria-label={favorite ? 'Прибрати з обраних' : 'Додати в обрані'}
                        title={favorite ? 'В обраних' : 'Додати в обрані'}
                        className={`absolute left-0 top-0 flex h-4 w-4 items-center justify-center rounded-full border border-surface-raised text-[10px] transition-transform hover:scale-110 ${
                          favorite
                            ? 'bg-amber-400 font-black text-black'
                            : 'bg-surface-sunken text-foreground-muted hover:text-amber-400'
                        }`}
                      >
                        ★
                      </button>

                      {placement && !isPreview && (
                        <div className="mt-1 flex items-center justify-between border-t border-surface-border pt-1">
                          <span className="font-mono text-[8px] text-brand-success-hover">
                            ({placement.x},{placement.y})
                          </span>

                          <button
                            type="button"
                            onClick={() => removeHeroFromMap(hero.id)}
                            aria-label={`Прибрати ${hero.name}`}
                            className="flex h-4 w-4 items-center justify-center rounded text-xs font-bold text-brand-danger hover:bg-brand-danger/10"
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
          </section>

          {/* SIDEBAR */}
          <aside className="order-3 flex min-w-0 flex-col gap-2 bg-surface-raised p-2 lg:col-start-2 lg:row-start-1">
            <div className="flex flex-wrap items-center justify-between gap-2 border-b border-surface-border pb-2">
              <h2 className="text-xs font-bold uppercase tracking-wider text-brand-accent">
                Керування розстановкою
              </h2>

              <div className="flex gap-1">
                {MAP_TYPES.map((type) => (
                  <button
                    key={type.value}
                    type="button"
                    onClick={() => changeMapType(type.value)}
                    aria-pressed={displayedMapType === type.value}
                    className={`rounded-md border px-2 py-1 text-[9px] font-bold uppercase transition-colors ${
                      displayedMapType === type.value
                        ? 'border-brand-accent bg-brand-accent text-foreground-onAccent'
                        : 'border-surface-border bg-surface-sunken text-foreground-secondary hover:border-brand-accent/50'
                    }`}
                  >
                    {type.label}
                  </button>
                ))}
              </div>
            </div>

            {error && (
              <div
                role="alert"
                className="rounded-lg border border-brand-danger/30 bg-brand-danger/10 p-2 text-[10px] text-brand-danger-hover"
              >
                {error}
              </div>
            )}

            {notice && (
              <div
                role="status"
                className="rounded-lg border border-brand-success/30 bg-brand-success/10 p-2 text-[10px] text-brand-success-hover"
              >
                {notice}
              </div>
            )}

            <div className="rounded-lg border border-surface-border bg-surface-sunken/40 p-2">
              <div className="mb-2 flex items-center justify-between gap-2">
                <span className="text-[10px] font-semibold text-foreground-secondary">
                  Герої на мапі
                </span>

                <span className="rounded-full border border-surface-border bg-surface-base px-2 py-0.5 text-[9px] font-bold text-foreground-muted">
                  {searchPlacements.length}/{MAX_HEROES}
                </span>
              </div>

              <div className="mb-2 grid grid-cols-5 gap-1.5">
                {Array.from({ length: MAX_HEROES }, (_, index) => {
                  const placement = searchPlacements[index];
                  const hero = placement
                    ? heroesById.get(String(placement.heroId))
                    : null;

                  return (
                    <div
                      key={index}
                      title={hero?.name || 'Порожній слот'}
                      className={`aspect-square overflow-hidden rounded-md border ${
                        hero
                          ? 'border-brand-success/50 bg-brand-success/10'
                          : 'border-dashed border-surface-border bg-surface-base'
                      }`}
                    >
                      {hero && <HeroPortrait hero={hero} className="h-full w-full" />}
                    </div>
                  );
                })}
              </div>

              {isPreview ? (
                <button
                  type="button"
                  onClick={closePreview}
                  className={`${buttonSecondaryClass} w-full`}
                >
                  ← Повернутися до пошуку
                </button>
              ) : (
                <div className="flex gap-1.5">
                  <button
                    type="button"
                    onClick={resetPlacements}
                    className={buttonSecondaryClass}
                  >
                    Очистити
                  </button>

                  <button
                    type="button"
                    onClick={searchPresets}
                    disabled={searchPlacements.length !== MAX_HEROES || searching || loadingMap}
                    className={`${buttonPrimaryClass} min-w-0 flex-1`}
                  >
                    {searching ? 'Пошук…' : 'Знайти точний збіг'}
                  </button>
                </div>
              )}
            </div>

            <div className="flex items-center justify-between gap-2 border-b border-surface-border pb-1.5">
              <h3 className="text-[10px] font-bold uppercase tracking-wider text-foreground-secondary">
                Результати пошуку
              </h3>

              <span className="rounded-full border border-surface-border bg-surface-sunken px-2 py-0.5 text-[9px] font-semibold text-foreground-muted">
                {results.length}
              </span>
            </div>

            {loadingDetails && (
              <p className="text-[10px] text-foreground-muted">
                Завантаження пресету…
              </p>
            )}

            <div className="max-h-[min(52vh,520px)] min-h-24 space-y-1.5 overflow-y-auto overscroll-contain pr-1">
              {results.length === 0 ? (
                <div className="rounded-lg border border-dashed border-surface-border bg-surface-base px-3 py-5 text-center text-[10px] text-foreground-muted">
                  {searching
                    ? 'Шукаємо точний збіг…'
                    : hasSearched
                    ? 'Пресетів зі 100% збігом не знайдено.'
                    : 'Розмісти 5 героїв на мапі та натисни «Знайти точний збіг».'}
                </div>
              ) : (
                results.map((preset) => {
                  const details = resultDetails[String(preset.id)];
                  const isOpened = String(openedPreset?.preset?.id) === String(preset.id);

                  const presetHeroes = (details?.heroes || [])
                    .map((placement) => heroesById.get(String(placement.heroId)))
                    .filter(Boolean);

                  return (
                    <article
                      key={preset.id}
                      className={`overflow-hidden rounded-lg border transition-colors ${
                        isOpened
                          ? 'border-brand-accent bg-brand-accent/10'
                          : 'border-surface-border bg-surface-base hover:border-brand-accent/40'
                      }`}
                    >
                      <div className="flex items-start justify-between gap-2 p-2 pb-1">
                        <button
                          type="button"
                          onClick={() => openPreset(preset)}
                          className="min-w-0 flex-1 text-left"
                        >
                          <p className="truncate text-[11px] font-bold text-foreground-primary">
                            {preset.name || preset.presetCode}
                          </p>

                          <p className="mt-0.5 truncate font-mono text-[9px] font-semibold text-brand-accent">
                            {preset.presetCode}
                          </p>
                        </button>

                        <button
                          type="button"
                          onClick={() => copyPresetCode(preset)}
                          className="shrink-0 rounded-md border border-brand-accent/40 bg-brand-accent/10 px-1.5 py-1 text-[8px] font-bold text-brand-accent transition-colors hover:bg-brand-accent hover:text-foreground-onAccent"
                        >
                          {copiedPresetId === preset.id ? '✓' : 'Копіювати'}
                        </button>
                      </div>

                      {preset.description && (
                        <p className="line-clamp-2 whitespace-pre-wrap px-2 text-[9px] leading-relaxed text-foreground-muted">
                          {preset.description}
                        </p>
                      )}

                      <div className="flex items-center gap-1 px-2 pb-2 pt-1.5">
                        {presetHeroes.length > 0 ? (
                          presetHeroes.slice(0, MAX_HEROES).map((hero) => (
                            <div
                              key={hero.id}
                              title={hero.name}
                              className={`h-8 w-8 shrink-0 rounded-md ring-1 ${getRarityRing(hero.rarity)}`}
                            >
                              <HeroPortrait hero={hero} className="h-full w-full rounded-md" />
                            </div>
                          ))
                        ) : (
                          <span className="text-[9px] text-foreground-muted">
                            {details ? 'Герої не знайдені' : 'Завантаження складу…'}
                          </span>
                        )}
                      </div>
                    </article>
                  );
                })
              )}
            </div>

            <p className="border-t border-surface-border pt-2 text-[9px] leading-relaxed text-foreground-muted">
              Для пошуку потрібні рівно 5 героїв. Враховуються герой, клітинка та напрямок атаки.
            </p>
          </aside>
        </div>
      </div>
    </div>
  );
}