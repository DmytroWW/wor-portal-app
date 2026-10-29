import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import api from '../../api/axios';

const MAP_TYPES = [
  { value: 'TOWER', label: 'Тільки вежі', count: 25 },
  { value: 'FORT', label: 'Тільки форти', count: 5 },
];

const RARITY_RING = {
  COMMON: 'ring-gray-400',
  UNCOMMON: 'ring-green-400',
  RARE: 'ring-blue-400',
  EPIC: 'ring-purple-400',
  LEGENDARY: 'ring-amber-400',
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

const getDirection = (direction) => ATTACK_DIRECTIONS.find((item) => item.value === direction) || ATTACK_DIRECTIONS[2];

const isHeroCompatible = (hero, tile) => {
  if (!hero || !tile || tile.tileType === 'EMPTY') return false;
  const heroClass = String(hero.className || '').toUpperCase();
  if (['DEFENDER', 'FIGHTER'].includes(heroClass)) return tile.tileType === 'GROUND';
  if (['MARKSMAN', 'MAGE', 'HEALER'].includes(heroClass)) return tile.tileType === 'PLATFORM';
  if (heroClass === 'TACTICIAN') return ['GROUND', 'PLATFORM'].includes(tile.tileType);
  return false;
};

const readFavoriteHeroIds = () => {
  if (typeof window === 'undefined') return [];
  try {
    const value = JSON.parse(window.localStorage.getItem('gvg_favorite_hero_ids') || '[]');
    return Array.isArray(value) ? value.map(String) : [];
  } catch { return []; }
};

const errorMessage = (error) =>
  error?.response?.data?.message ||
  error?.response?.data?.error ||
  error?.message ||
  'Сталася помилка запиту.';

const cn = (...values) => values.filter(Boolean).join(' ');

function HeroPortrait({ hero, className = 'h-8 w-8' }) {
  const [failed, setFailed] = useState(false);
  const firstLetter = hero?.name?.trim()?.charAt(0)?.toUpperCase() || '?';
  return (
    <div
      className={cn('relative shrink-0 overflow-hidden rounded-md bg-surface-overlay ring-1', RARITY_RING[String(hero?.rarity || '').toUpperCase()] || 'ring-surface-border', className)}
      title={hero?.name || 'Герой'}
    >
      {hero?.imageSlug && !failed ? (
        <img
          src={`/images/heroes/${hero.imageSlug}.png`}
          alt={hero.name || 'Герой'}
          draggable="false"
          className="h-full w-full object-cover"
          onError={() => setFailed(true)}
        />
      ) : (
        <span className="flex h-full w-full items-center justify-center text-[10px] font-bold text-foreground-primary">
          {firstLetter}
        </span>
      )}
    </div>
  );
}

function SoldierPortrait({ soldier, className = 'h-7 w-7' }) {
  const [failed, setFailed] = useState(false);
  const firstLetter = soldier?.name?.trim()?.charAt(0)?.toUpperCase() || 'S';
  return (
    <div
      className={cn('relative shrink-0 overflow-hidden rounded-md bg-surface-overlay ring-1', RARITY_RING[String(soldier?.rarity || '').toUpperCase()] || 'ring-surface-border', className)}
      title={`${soldier?.name || 'Демон-солдат'} · рівень ${soldier?.level ?? 1}`}
    >
      {soldier?.imageSlug && !failed ? (
        <img
          src={`/images/demon-soldiers/${soldier.imageSlug}.webp`}
          alt={soldier.name || 'Демон-солдат'}
          draggable="false"
          className="h-full w-full object-cover"
          onError={() => setFailed(true)}
        />
      ) : (
        <span className="flex h-full w-full items-center justify-center text-[10px] font-bold text-foreground-primary">
          {firstLetter}
        </span>
      )}
    </div>
  );
}

function PresetMiniature({ snapshot, heroesById, soldiersById, onCopy, copied }) {
  const preset = snapshot?.preset;
  const heroes = (snapshot?.heroes || []).map((item) => heroesById.get(String(item.heroId))).filter(Boolean);
  const soldiers = (snapshot?.soldiers || []).map((item) => {
    const soldier = soldiersById.get(String(item.soldierId));
    return soldier ? { ...soldier, level: item.level ?? soldier.level ?? 1 } : null;
  }).filter(Boolean);

  return (
    <article className="min-w-0 rounded-lg border border-surface-border bg-surface-base p-2 shadow-sm">
      <div className="flex min-w-0 items-start justify-between gap-2">
        <div className="min-w-0">
          <p className="truncate text-[11px] font-bold text-foreground-primary" title={preset?.name || preset?.presetCode}>
            {preset?.name || preset?.presetCode || 'Пресет атаки'}
          </p>
          <p className="truncate font-mono text-[10px] text-brand-accent" title={preset?.presetCode}>
            {preset?.presetCode || 'Без коду'}
          </p>
        </div>
        <button
          type="button"
          onClick={() => onCopy(preset)}
          disabled={!preset?.presetCode}
          className="shrink-0 rounded-md border border-brand-accent/40 bg-brand-accent/10 px-2 py-1 text-[9px] font-bold text-brand-accent transition hover:bg-brand-accent hover:text-foreground-onAccent disabled:opacity-40"
        >
          {copied ? 'Скопійовано' : 'Копіювати'}
        </button>
      </div>
      {preset?.description ? (
        <p className="mt-1 line-clamp-2 text-[9px] leading-snug text-foreground-muted" title={preset.description}>
          {preset.description}
        </p>
      ) : null}
      <div className="mt-2 flex min-w-0 flex-wrap items-center gap-1">
        {heroes.slice(0, 5).map((hero) => <HeroPortrait key={hero.id} hero={hero} className="h-6 w-6" />)}
        {soldiers.slice(0, 5).map((soldier) => <SoldierPortrait key={soldier.id} soldier={soldier} className="h-6 w-6" />)}
        {!heroes.length && !soldiers.length ? <span className="text-[9px] text-foreground-muted">Немає мініатюр</span> : null}
      </div>
    </article>
  );
}

export default function GvgBattle({ onCreatePreset }) {
  const [mapType, setMapType] = useState('TOWER');
  const [activeMap, setActiveMap] = useState(null);
  const [activeTiles, setActiveTiles] = useState([]);
  const [heroes, setHeroes] = useState([]);
  const [soldiers, setSoldiers] = useState([]);
  const [round, setRound] = useState(null);
  const [slots, setSlots] = useState([]);
  const [history, setHistory] = useState([]);
  const [historyOpen, setHistoryOpen] = useState(false);
  const [historyView, setHistoryView] = useState(false);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [notice, setNotice] = useState('');
  const [filterUnbreached, setFilterUnbreached] = useState(false);
  const [filterWithCodes, setFilterWithCodes] = useState(false);
  const [attackPageBySlot, setAttackPageBySlot] = useState({});
  const [newRoundOpen, setNewRoundOpen] = useState(false);
  const [newOpponentName, setNewOpponentName] = useState('');
  const [creatingRound, setCreatingRound] = useState(false);
  const [renameOpen, setRenameOpen] = useState(false);
  const [renameValue, setRenameValue] = useState('');
  const [renaming, setRenaming] = useState(false);
  const [copiedPresetId, setCopiedPresetId] = useState(null);
  const [defenseEditorSlotId, setDefenseEditorSlotId] = useState(null);
  const [defenseDraft, setDefenseDraft] = useState({});
  const [selectedDefenseHeroId, setSelectedDefenseHeroId] = useState(null);
  const [defenseNickname, setDefenseNickname] = useState('');
  const [defenseBattlePower, setDefenseBattlePower] = useState('');
  const [defenseMirrorNote, setDefenseMirrorNote] = useState('');
  const [defenseSearchQuery, setDefenseSearchQuery] = useState('');
  const [defenseClassFilter, setDefenseClassFilter] = useState('ALL');
  const [defenseSortBy, setDefenseSortBy] = useState('NAME');
  const [favoriteHeroIds, setFavoriteHeroIds] = useState(readFavoriteHeroIds);
  const [savingDefense, setSavingDefense] = useState(false);
  const [defenseModalError, setDefenseModalError] = useState('');
  const [viewportWidth, setViewportWidth] = useState(() => typeof window !== 'undefined' ? window.innerWidth : 1280);
  const defenseHeroListRef = useRef(null);
  const requestIdRef = useRef(0);

  const heroesById = useMemo(() => new Map(heroes.map((hero) => [String(hero.id), hero])), [heroes]);
  const soldiersById = useMemo(() => new Map(soldiers.map((soldier) => [String(soldier.id), soldier])), [soldiers]);

  const setRoundData = useCallback((data) => {
    setRound(data || null);
    setSlots(Array.isArray(data?.slots) ? data.slots : []);
    setAttackPageBySlot({});
  }, []);

  const loadData = useCallback(async (targetMapType = mapType, historicalRoundId = null) => {
    const requestId = ++requestIdRef.current;
    setLoading(true);
    setError('');
    try {
      const [mapResponse, heroesResponse, soldiersResponse, roundResponse] = await Promise.all([
        api.get(`/gvg/maps/active?type=${targetMapType}`),
        api.get('/heroes'),
        api.get('/demon-soldiers'),
        historicalRoundId
          ? api.get(`/gvg/battle/rounds/${historicalRoundId}?mapType=${targetMapType}`)
          : api.get(`/gvg/battle/active?mapType=${targetMapType}`).catch((err) => {
              if (err?.response?.status === 204 || err?.response?.status === 404) return { status: 204, data: null };
              throw err;
            }),
      ]);
      if (requestId !== requestIdRef.current) return;
      const map = mapResponse.data;
      const tileResponse = map?.id ? await api.get(`/gvg/maps/${map.id}/tiles`) : { data: [] };
      if (requestId !== requestIdRef.current) return;
      setActiveMap(map || null);
      setActiveTiles(Array.isArray(tileResponse.data) ? tileResponse.data : []);
      setHeroes(Array.isArray(heroesResponse.data) ? heroesResponse.data : []);
      setSoldiers(Array.isArray(soldiersResponse.data) ? soldiersResponse.data : []);
      const roundData = roundResponse.status === 204 ? null : roundResponse.data;
      setRoundData(roundData);
      setHistoryView(Boolean(historicalRoundId));
    } catch (err) {
      if (requestId === requestIdRef.current) setError(errorMessage(err));
    } finally {
      if (requestId === requestIdRef.current) setLoading(false);
    }
  }, [mapType, setRoundData]);

  useEffect(() => {
    loadData(mapType);
  }, [mapType, loadData]);

  useEffect(() => {
    const onResize = () => setViewportWidth(window.innerWidth);
    window.addEventListener('resize', onResize);
    return () => window.removeEventListener('resize', onResize);
  }, []);

  // Refresh the active round periodically so other guild members' updates appear without reloading.
  useEffect(() => {
    if (!round?.id || round.status !== 'ACTIVE' || historyView) return undefined;
    const timer = window.setInterval(async () => {
      if (savingDefense || document.activeElement?.hasAttribute('data-battle-field')) return;
      try {
        const response = await api.get(`/gvg/battle/active?mapType=${mapType}`);
        if (response.status !== 204 && response.data) setRoundData(response.data);
      } catch {
        // Keep the current screen usable during a temporary network interruption.
      }
    }, 5000);
    return () => window.clearInterval(timer);
  }, [mapType, round?.id, round?.status, historyView, savingDefense, setRoundData]);

  const loadHistory = async () => {
    setError('');
    try {
      const response = await api.get('/gvg/battle/rounds/history');
      setHistory(Array.isArray(response.data) ? response.data : []);
      setHistoryOpen(true);
    } catch (err) {
      setError(errorMessage(err));
    }
  };

  const openHistoricalRound = async (roundId) => {
    setHistoryOpen(false);
    await loadData(mapType, roundId);
  };

  const createNextRound = async () => {
    if (!newOpponentName.trim()) {
      setError('Введи назву нового опонента.');
      return;
    }
    setCreatingRound(true);
    setError('');
    try {
      const response = await api.post(`/gvg/battle/rounds/next?mapType=${mapType}`, { opponentName: newOpponentName.trim() });
      setRoundData(response.data);
      setHistoryView(false);
      setNewRoundOpen(false);
      setNewOpponentName('');
      setNotice(`Раунд ${response.data.roundNumber} активовано.`);
      api.get('/gvg/battle/rounds/history').then((historyResponse) => setHistory(Array.isArray(historyResponse.data) ? historyResponse.data : [])).catch(() => {});
    } catch (err) {
      setError(errorMessage(err));
    } finally {
      setCreatingRound(false);
    }
  };

  const saveOpponentName = async () => {
    if (!round?.id || !renameValue.trim()) {
      setError('Назва опонента не може бути порожньою.');
      return;
    }
    setRenaming(true);
    setError('');
    try {
      const response = await api.patch(`/gvg/battle/rounds/${round.id}/opponent?mapType=${mapType}`, { opponentName: renameValue.trim() });
      setRoundData(response.data);
      setRenameOpen(false);
      setNotice('Назву опонента оновлено.');
    } catch (err) {
      setError(errorMessage(err));
    } finally {
      setRenaming(false);
    }
  };

  const updateSlotLocal = (slotId, updates) => {
    setSlots((current) => current.map((slot) => String(slot.id) === String(slotId) ? { ...slot, ...updates } : slot));
  };

  // Tower/Fort position has two enemy teams (.1 and .2) with the same opponent.
  // Mirror only the nickname in the UI; battle power and mirror notes stay independent.
  const syncPairedNicknameLocal = (sourceSlotId, nickname) => {
    const normalizedNickname = String(nickname ?? '').trim();
    if (!normalizedNickname) return;

    const sourceSlot = slots.find((slot) => String(slot.id) === String(sourceSlotId));
    if (!sourceSlot) return;

    const pairedLaneNumber = Number(sourceSlot.laneNumber) === 1 ? 2 : 1;
    setSlots((current) => current.map((slot) => {
      const isPairedSlot =
        String(slot.id) !== String(sourceSlotId) &&
        String(slot.mapType) === String(sourceSlot.mapType) &&
        Number(slot.slotNumber) === Number(sourceSlot.slotNumber) &&
        Number(slot.laneNumber) === pairedLaneNumber;

      return isPairedSlot ? { ...slot, opponentNickname: normalizedNickname } : slot;
    }));
  };

  const toggleBreach = async (slot, breached) => {
    if (round?.status !== 'ACTIVE' || historyView) return;
    setError('');
    try {
      const response = await api.patch(`/gvg/battle/slots/${slot.id}/breach`, { breached });
      updateSlotLocal(slot.id, response.data);
    } catch (err) {
      setError(`${slot.title}: ${errorMessage(err)}`);
    }
  };

  const copyPresetCode = async (preset) => {
    const presetCode = String(preset?.presetCode || '');
    if (!presetCode) return;
    try {
      await navigator.clipboard.writeText(presetCode);
      setCopiedPresetId(preset.id);
      setNotice(`Код «${presetCode}» скопійовано.`);
      window.setTimeout(() => setCopiedPresetId((current) => current === preset.id ? null : current), 1600);
    } catch {
      setError('Не вдалося скопіювати код пресету.');
    }
  };

  const currentCalib = useMemo(() => interpolateGridCalibration(viewportWidth, mapType), [viewportWidth, mapType]);
  const mapTileLookup = useMemo(() => new Map(activeTiles.map((tile) => [`${tile.x},${tile.y}`, tile])), [activeTiles]);
  const defensePlacements = useMemo(() => Object.values(defenseDraft), [defenseDraft]);
  const defensePlacementsByTile = useMemo(() => new Map(defensePlacements.map((placement) => [String(placement.tileId), placement])), [defensePlacements]);
  const heroClasses = useMemo(() => [...new Set(heroes.map((hero) => hero.className).filter(Boolean))].sort(), [heroes]);
  const visibleDefenseHeroes = useMemo(() => {
    let list = heroes;
    if (defenseClassFilter !== 'ALL') list = list.filter((hero) => hero.className === defenseClassFilter);
    if (defenseSearchQuery.trim()) {
      const query = defenseSearchQuery.trim().toLowerCase();
      list = list.filter((hero) => String(hero.name || '').toLowerCase().includes(query));
    }
    const favoriteSet = new Set(favoriteHeroIds.map(String));
    return [...list].sort((a, b) => {
      const aFav = favoriteSet.has(String(a.id));
      const bFav = favoriteSet.has(String(b.id));
      if (aFav !== bFav) return aFav ? -1 : 1;
      if (defenseSortBy === 'CLASS') return String(a.className || '').localeCompare(String(b.className || '')) || String(a.name || '').localeCompare(String(b.name || ''));
      return String(a.name || '').localeCompare(String(b.name || ''));
    });
  }, [heroes, defenseClassFilter, defenseSearchQuery, defenseSortBy, favoriteHeroIds]);

  const openDefenseEditor = (slot) => {
    const savedPlacements = Array.isArray(slot.defenseHeroes) && slot.defenseHeroes.length
      ? slot.defenseHeroes
      : (slot.defensePreset?.heroes || []);
    const draft = {};
    savedPlacements.forEach((placement) => {
      if (placement?.heroId == null || placement?.tileId == null) return;
      draft[String(placement.heroId)] = {
        heroId: placement.heroId,
        tileId: placement.tileId,
        x: placement.x,
        y: placement.y,
        attackDirection: placement.attackDirection || 'DOWN',
      };
    });
    setDefenseEditorSlotId(slot.id);
    setDefenseDraft(draft);
    setSelectedDefenseHeroId(null);
    setDefenseNickname(slot.opponentNickname || '');
    setDefenseBattlePower(slot.battlePower == null ? '' : String(slot.battlePower));
    setDefenseMirrorNote(slot.mirrorNote || '');
    setDefenseSearchQuery('');
    setDefenseClassFilter('ALL');
    setDefenseSortBy('NAME');
    setDefenseModalError('');
  };

  const closeDefenseEditor = () => {
    if (savingDefense) return;
    setDefenseEditorSlotId(null);
    setSelectedDefenseHeroId(null);
    setDefenseModalError('');
  };

  const placeDefenseHero = (tile) => {
    if (!isEditable) return;
    setDefenseModalError('');
    if (!selectedDefenseHeroId) {
      setDefenseModalError('Спочатку вибери героя в каталозі внизу.');
      return;
    }
    if (!tile || tile.tileType === 'EMPTY') return;
    const hero = heroesById.get(String(selectedDefenseHeroId));
    if (!isHeroCompatible(hero, tile)) {
      setDefenseModalError(`Герой ${hero?.name || ''} не може стояти на клітинці типу ${tile.tileType}.`);
      return;
    }
    const occupied = defensePlacementsByTile.get(String(tile.id));
    if (occupied && String(occupied.heroId) !== String(selectedDefenseHeroId)) {
      setDefenseModalError('Ця клітинка вже зайнята іншим героєм.');
      return;
    }
    const previous = defenseDraft[String(selectedDefenseHeroId)];
    if (!previous && defensePlacements.length >= 5) {
      setDefenseModalError('У дефі має бути рівно 5 героїв. Прибери одного або вибери вже розміщеного героя для переміщення.');
      return;
    }
    setDefenseDraft((current) => ({
      ...current,
      [String(selectedDefenseHeroId)]: {
        heroId: hero.id,
        tileId: tile.id,
        x: tile.x,
        y: tile.y,
        attackDirection: current[String(selectedDefenseHeroId)]?.attackDirection || 'DOWN',
      },
    }));
    setSelectedDefenseHeroId(null);
  };

  const rotateDefenseHero = (heroId) => {
    if (!isEditable) return;
    setDefenseDraft((current) => {
      const key = String(heroId);
      const placement = current[key];
      if (!placement) return current;
      const currentIndex = ATTACK_DIRECTIONS.findIndex((item) => item.value === placement.attackDirection);
      const next = ATTACK_DIRECTIONS[(currentIndex + 1) % ATTACK_DIRECTIONS.length];
      return { ...current, [key]: { ...placement, attackDirection: next.value } };
    });
  };

  const removeDefenseHero = (heroId) => {
    if (!isEditable) return;
    setDefenseDraft((current) => {
      const updated = { ...current };
      delete updated[String(heroId)];
      return updated;
    });
    if (String(selectedDefenseHeroId) === String(heroId)) setSelectedDefenseHeroId(null);
    setDefenseModalError('');
  };

  const toggleFavoriteHero = (heroId, event) => {
    event.stopPropagation();
    const id = String(heroId);
    setFavoriteHeroIds((current) => {
      const updated = current.includes(id) ? current.filter((item) => item !== id) : [...current, id];
      try { window.localStorage.setItem('gvg_favorite_hero_ids', JSON.stringify(updated)); } catch { /* Storage can be unavailable. */ }
      return updated;
    });
  };

  const saveDefenseLayout = async () => {
    if (!defenseEditorSlotId || !activeMap?.id || !isEditable) return;
    if (defensePlacements.length !== 0 && defensePlacements.length !== 5) {
      setDefenseModalError('Збереження можливе лише з 5 героями. Для видалення дефу очисти всі позиції.');
      return;
    }
    const power = defenseBattlePower === '' ? null : Number(defenseBattlePower);
    if (power != null && (!Number.isFinite(power) || power < 0)) {
      setDefenseModalError('БМ має бути невід’ємним числом.');
      return;
    }
    setSavingDefense(true);
    setDefenseModalError('');
    setError('');
    try {
      const response = await api.put(`/gvg/battle/slots/${defenseEditorSlotId}/defense`, {
        mapId: activeMap.id,
        heroes: defensePlacements.map((placement) => ({
          heroId: Number(placement.heroId),
          tileId: Number(placement.tileId),
          attackDirection: placement.attackDirection || 'DOWN',
        })),
        opponentNickname: defenseNickname.trim() || null,
        battlePower: power,
        mirrorNote: defenseMirrorNote.trim() || null,
      });
      updateSlotLocal(defenseEditorSlotId, response.data);
      syncPairedNicknameLocal(defenseEditorSlotId, response.data.opponentNickname);
      setNotice(defensePlacements.length ? `Розстановку для ${response.data.title} збережено.` : `Деф для ${response.data.title} очищено.`);
      setDefenseEditorSlotId(null);
      setSelectedDefenseHeroId(null);
    } catch (err) {
      setDefenseModalError(errorMessage(err));
    } finally {
      setSavingDefense(false);
    }
  };

  const startPresetFromBattle = (sourceSlot, placementsInput, metadata = {}) => {
    if (!sourceSlot || !isEditable || historyView) return;

    const inputPlacements = Array.isArray(placementsInput)
      ? placementsInput
      : Object.values(placementsInput || {});

    const placements = inputPlacements
      .filter((placement) => placement?.heroId != null && placement?.tileId != null)
      .map((placement) => ({
        heroId: placement.heroId,
        tileId: placement.tileId,
        x: placement.x,
        y: placement.y,
        attackDirection: placement.attackDirection || 'DOWN',
      }));

    if (placements.length !== 5) {
      if (defenseEditorSlotId != null && String(defenseEditorSlotId) === String(sourceSlot.id)) {
        setDefenseModalError('Щоб створити пресет, розмісти рівно 5 героїв.');
      } else {
        openDefenseEditor(sourceSlot);
        setDefenseModalError('Щоб створити пресет, спочатку розмісти рівно 5 героїв.');
      }
      return;
    }

    const sourceMapType = String(sourceSlot.mapType || activeMap?.mapType || mapType).toUpperCase() === 'FORT'
      ? 'FORT'
      : 'TOWER';

    const payload = {
      version: 1,
      source: 'gvg-battle',
      mapType: sourceMapType,
      mapId: activeMap?.id ?? null,
      slotId: sourceSlot.id,
      slotTitle: sourceSlot.title || 'GvG',
      opponentNickname: metadata.opponentNickname ?? sourceSlot.opponentNickname ?? '',
      battlePower: metadata.battlePower ?? sourceSlot.battlePower ?? null,
      mirrorNote: metadata.mirrorNote ?? sourceSlot.mirrorNote ?? '',
      suggestedName: sourceSlot.title ? `Контратака ${sourceSlot.title}` : 'Контратака GvG',
      heroes: placements,
    };

    try {
      window.sessionStorage.setItem(
        'gvg-battle-preset-draft',
        JSON.stringify(payload)
      );

      if (typeof onCreatePreset === 'function') {
        onCreatePreset();
      } else {
        setError('Не вдалося відкрити сторінку створення пресету.');
      }
    } catch (err) {
      const message = 'Не вдалося передати розстановку в створення пресету. Перевір доступ до sessionStorage.';
      if (defenseEditorSlotId != null && String(defenseEditorSlotId) === String(sourceSlot.id)) {
        setDefenseModalError(message);
      } else {
        setError(message);
      }
    }
  };

  const scrollDefenseHeroList = (direction) => {
    defenseHeroListRef.current?.scrollBy({ left: direction * 260, behavior: 'smooth' });
  };

  const displayedSlots = useMemo(() => slots.filter((slot) => {
    if (filterUnbreached && slot.breached) return false;
    if (filterWithCodes && !(slot.recommendedAttacks || []).length) return false;
    return true;
  }), [slots, filterUnbreached, filterWithCodes]);

  const isEditable = round?.status === 'ACTIVE' && !historyView;
  const inputClass = 'w-full min-w-0 rounded-md border border-surface-border bg-surface-sunken px-2 py-1.5 text-[10px] text-foreground-primary outline-none placeholder:text-foreground-muted focus:border-brand-accent disabled:opacity-50';
  const buttonClass = 'inline-flex items-center justify-center gap-1 rounded-lg border border-surface-border bg-surface-sunken px-2.5 py-1.5 text-[10px] font-semibold text-foreground-secondary transition hover:border-brand-accent/50 hover:text-foreground-primary disabled:cursor-not-allowed disabled:opacity-50';

  return (
    <div className="mx-auto max-w-[1500px] space-y-3 px-3 py-3 text-foreground-primary md:px-4">
      <section className="rounded-xl border border-surface-border bg-surface-raised p-3 shadow-surface">
        <div className="flex flex-col gap-3 xl:flex-row xl:items-start xl:justify-between">
          <div className="min-w-0 flex-1">
            <div className="flex flex-wrap items-center gap-2">
              <h1 className="text-base font-black uppercase tracking-wide sm:text-lg">⚔ GvG Battle: Round Management</h1>
              {round ? <span className="rounded-full border border-brand-accent/30 bg-brand-accent/10 px-2 py-1 text-[10px] font-bold text-brand-accent">Раунд {round.roundNumber}</span> : null}
              {historyView ? <span className="rounded-full border border-brand-danger/30 bg-brand-danger/10 px-2 py-1 text-[10px] font-bold text-brand-danger-hover">Історія · лише перегляд</span> : null}
            </div>
            <div className="mt-1 flex flex-wrap items-center gap-2 text-xs text-foreground-secondary">
              <span className="text-foreground-muted">Season {activeMap?.seasonNumber ?? '—'}</span>
              {round ? <span>Опонент: <strong className="text-foreground-primary">{round.opponentName}</strong></span> : <span>Активного раунду ще немає.</span>}
              {round && isEditable ? (
                <button type="button" title="Змінити назву опонента" onClick={() => { setRenameValue(round.opponentName || ''); setRenameOpen(true); }} className="rounded px-1 text-brand-accent hover:bg-brand-accent/10">✎</button>
              ) : null}
            </div>
          </div>
          <div className="flex flex-wrap items-center gap-2">
            <button type="button" onClick={loadHistory} className={buttonClass}>Історія раундів</button>
            {historyView ? <button type="button" onClick={() => loadData(mapType)} className={buttonClass}>До активного раунду</button> : null}
            <button type="button" onClick={() => { setNewOpponentName(''); setNewRoundOpen(true); }} className="inline-flex items-center justify-center rounded-lg bg-brand-accent px-4 py-2 text-xs font-black text-foreground-onAccent shadow-brand-accent transition hover:bg-brand-accent-hover">
              {round ? 'Створити наступний раунд +' : 'Створити раунд +'}
            </button>
          </div>
        </div>

        <div className="mt-3 flex flex-wrap items-center gap-2 border-t border-surface-border pt-3">
          {MAP_TYPES.map((type) => {
            const active = mapType === type.value;
            return (
              <button key={type.value} type="button" onClick={() => setMapType(type.value)} aria-pressed={active}
                className={cn('rounded-lg border px-3 py-2 text-xs font-bold transition', active ? 'border-brand-accent bg-brand-accent text-foreground-onAccent' : 'border-surface-border bg-surface-sunken text-foreground-secondary hover:border-brand-accent/50')}>
                {type.label} ({type.count})
              </button>
            );
          })}
          <label className="ml-0 flex items-center gap-2 rounded-lg border border-surface-border bg-surface-sunken px-3 py-2 text-xs text-foreground-secondary sm:ml-2">
            <input type="checkbox" checked={filterUnbreached} onChange={(event) => setFilterUnbreached(event.target.checked)} className="accent-amber-500" /> Не пробиті
          </label>
          <label className="flex items-center gap-2 rounded-lg border border-surface-border bg-surface-sunken px-3 py-2 text-xs text-foreground-secondary">
            <input type="checkbox" checked={filterWithCodes} onChange={(event) => setFilterWithCodes(event.target.checked)} className="accent-amber-500" /> Є коди
          </label>
        </div>
      </section>

      {error ? <div role="alert" className="rounded-lg border border-brand-danger/30 bg-brand-danger/10 p-3 text-xs text-brand-danger-hover">{error}</div> : null}
      {notice ? <div role="status" className="rounded-lg border border-brand-success/30 bg-brand-success/10 p-3 text-xs text-brand-success-hover">{notice}</div> : null}

      {loading ? (
        <div className="rounded-xl border border-surface-border bg-surface-raised p-8 text-center text-sm text-foreground-secondary">Завантаження GvG War Room…</div>
      ) : !round ? (
        <div className="rounded-xl border border-dashed border-surface-border bg-surface-raised p-10 text-center">
          <p className="text-sm font-semibold">Раунд ще не створено</p>
          <p className="mt-1 text-xs text-foreground-muted">Створи перший раунд, щоб з'явилися слоти оборони для веж і фортів.</p>
          <button type="button" onClick={() => setNewRoundOpen(true)} className="mt-4 rounded-lg bg-brand-accent px-4 py-2 text-xs font-bold text-foreground-onAccent">Створити раунд</button>
        </div>
      ) : (
        <div className="space-y-2">
          <div className="flex items-center justify-between gap-2 px-1 text-[10px] text-foreground-muted">
            <span>{displayedSlots.length} із {slots.length} слотів · {mapType === 'TOWER' ? '25 позицій × 2 дефи' : '5 позицій × 2 дефи'}</span>
            {round.status === 'LOCKED' ? <span className="font-bold text-brand-danger-hover">Раунд заблоковано</span> : <span className="font-bold text-brand-success-hover">Раунд активний</span>}
          </div>
          <div className="grid grid-cols-1 gap-2 2xl:grid-cols-2">
            {displayedSlots.map((slot) => {
              const attackCards = slot.recommendedAttacks || [];
              const pages = Math.max(1, Math.ceil(attackCards.length / 2));
              const page = Math.min(attackPageBySlot[slot.id] || 0, pages - 1);
              const visibleAttacks = attackCards.slice(page * 2, page * 2 + 2);
              const defenseHeroes = (slot.defenseHeroes?.length ? slot.defenseHeroes : (slot.defensePreset?.heroes || [])).map((item) => heroesById.get(String(item.heroId))).filter(Boolean);
              return (
                <article key={slot.id} className={cn('overflow-hidden rounded-lg border shadow-sm', slot.breached ? 'border-red-500/70 bg-red-950/20' : 'border-surface-border bg-surface-raised')}>
                  <div className="grid min-w-0 grid-cols-1 gap-0 md:grid-cols-[minmax(0,1fr)_minmax(0,1fr)]">
                    <div className={cn('min-w-0 border-b p-2 md:border-b-0 md:border-r', slot.breached ? 'border-red-500/40 bg-red-950/10' : 'border-surface-border')}>
                      <div className="flex items-start justify-between gap-2">
                        <h2 className="text-xs font-black uppercase tracking-wide">{slot.title}</h2>
                        <label className={cn('flex shrink-0 items-center gap-1.5 rounded-md border px-2 py-1 text-[9px] font-bold', slot.breached ? 'border-red-500/50 bg-red-500/10 text-red-300' : 'border-surface-border text-foreground-secondary', !isEditable && 'opacity-70')}>
                          <input type="checkbox" checked={Boolean(slot.breached)} disabled={!isEditable} onChange={(event) => toggleBreach(slot, event.target.checked)} className="accent-red-500" /> ПРОБИТИЙ
                        </label>
                      </div>
                      {slot.breachedBy?.length ? <p className="mt-1 text-[9px] font-semibold text-red-300">Пробили: {slot.breachedBy.join(', ')}</p> : null}
                      <div className="mt-2 rounded-lg border border-surface-border bg-surface-base/70 p-2">
                        <div className="flex min-w-0 flex-wrap items-center gap-2">
                          <button
                            type="button"
                            aria-label={`Відкрити розстановку дефу ${slot.title}`}
                            disabled={savingDefense}
                            onClick={() => openDefenseEditor(slot)}
                            className={cn('inline-flex shrink-0 items-center gap-1.5 rounded-lg border px-3 py-2 text-[10px] font-bold transition', 'border-brand-accent/50 bg-brand-accent/10 text-brand-accent hover:bg-brand-accent hover:text-foreground-onAccent disabled:opacity-50')}
                          >
                            <span aria-hidden="true">▦</span> Розстановка
                          </button>
                          <div className="flex min-w-0 flex-wrap items-center gap-1">
                            {defenseHeroes.slice(0, 5).map((hero) => <HeroPortrait key={hero.id} hero={hero} className="h-8 w-8" />)}
                            {defenseHeroes.length < 5 ? <span className="text-[9px] text-foreground-muted">{defenseHeroes.length ? `${defenseHeroes.length}/5 героїв` : 'Деф не призначено'}</span> : null}
                          </div>
                        </div>
                        <div className="mt-2 grid min-w-0 grid-cols-[minmax(0,1fr)_auto] items-start gap-x-3 gap-y-1 border-t border-surface-border/70 pt-2 text-[9px]">
                          <div className="min-w-0">
                            <p className="text-foreground-muted">Оппонент</p>
                            <p className="truncate font-semibold text-foreground-secondary" title={slot.opponentNickname || 'Нікнейм не вказано'}>{slot.opponentNickname || 'Не вказано'}</p>
                          </div>
                          <div className="text-right">
                            <p className="text-foreground-muted">БМ</p>
                            <p className="font-bold tabular-nums text-foreground-secondary">{slot.battlePower != null ? Number(slot.battlePower).toLocaleString() : '—'}</p>
                          </div>
                          {slot.mirrorNote ? <p className="col-span-2 line-clamp-1 text-foreground-muted" title={slot.mirrorNote}>Дзеркало: <span className="text-foreground-secondary">{slot.mirrorNote}</span></p> : null}
                        </div>
                      </div>
                    </div>

                    <div className="min-w-0 p-2">
                      <div className="mb-2 flex items-center justify-between gap-2">
                        <h3 className="text-[11px] font-bold text-foreground-primary">Matched Attack Presets</h3>
                        <div className="flex items-center gap-1">
                          <button type="button" disabled={page <= 0} onClick={() => setAttackPageBySlot((current) => ({ ...current, [slot.id]: Math.max(0, page - 1) }))} className={buttonClass}>‹</button>
                          <span className="min-w-8 text-center text-[9px] text-foreground-muted">{page + 1}/{pages}</span>
                          <button type="button" disabled={page >= pages - 1} onClick={() => setAttackPageBySlot((current) => ({ ...current, [slot.id]: Math.min(pages - 1, page + 1) }))} className={buttonClass}>›</button>
                        </div>
                      </div>
                      {attackCards.length ? (
                        <div className="grid grid-cols-1 gap-1.5 sm:grid-cols-2">
                          {visibleAttacks.map((snapshot) => <PresetMiniature key={snapshot.preset.id} snapshot={snapshot} heroesById={heroesById} soldiersById={soldiersById} onCopy={copyPresetCode} copied={copiedPresetId === snapshot.preset.id} />)}
                        </div>
                      ) : (
                        <div className="flex min-h-[100px] flex-col items-center justify-center rounded-lg border border-dashed border-surface-border bg-surface-base/70 p-3 text-center">
                          <p className="text-[10px] font-semibold text-foreground-secondary">Авто-пошук: немає збігів</p>
                          <p className="mt-1 text-[9px] text-foreground-muted">{defenseHeroes.length === 5 ? 'Для цього дефу exact-пошук не знайшов атак.' : 'Відкрий «Розстановка» й розмісти п’ятьох героїв, щоб запустити exact-пошук.'}</p>
                          <button
                            type="button"
                            disabled={!isEditable}
                            onClick={() => {
                              const savedPlacements = Array.isArray(slot.defenseHeroes) && slot.defenseHeroes.length
                                ? slot.defenseHeroes
                                : (slot.defensePreset?.heroes || []);
                              if (savedPlacements.length !== 5) {
                                openDefenseEditor(slot);
                                return;
                              }
                              startPresetFromBattle(slot, savedPlacements);
                            }}
                            className="mt-2 rounded-md border border-brand-accent/40 bg-brand-accent/10 px-2.5 py-1 text-[9px] font-bold text-brand-accent hover:bg-brand-accent hover:text-foreground-onAccent disabled:opacity-40"
                          >
                            {defenseHeroes.length === 5 ? 'Створити пресет із дефу' : 'Розставити героїв'}
                          </button>
                        </div>
                      )}
                    </div>
                  </div>
                </article>
              );
            })}
          </div>
        </div>
      )}

      {defenseEditorSlotId != null ? (() => {
        const editingSlot = slots.find((item) => String(item.id) === String(defenseEditorSlotId));
        const currentDim = MAP_DIMENSIONS[mapType] || MAP_DIMENSIONS.TOWER;
        const placedHeroCount = defensePlacements.length;
        return (
          <div
            className="fixed inset-0 z-[150] flex items-center justify-center bg-black/75 p-2 sm:p-4"
            role="presentation"
            onMouseDown={(event) => { if (event.target === event.currentTarget) closeDefenseEditor(); }}
          >
            <section
              role="dialog"
              aria-modal="true"
              aria-labelledby="defense-editor-title"
              className="gvg-page max-h-[96vh] w-full max-w-[1440px] overflow-y-auto rounded-2xl border border-surface-border bg-surface-raised text-foreground-primary shadow-2xl"
              onKeyDown={(event) => { if (event.key === 'Escape') closeDefenseEditor(); }}
            >
              <style>{RESPONSIVE_TYPOGRAPHY_CSS}</style>
              <div className="flex items-start justify-between gap-3 border-b border-surface-border bg-surface-base/70 px-3 py-2.5 sm:px-4">
                <div className="min-w-0">
                  <h2 id="defense-editor-title" className="text-sm font-black tracking-wide sm:text-base">Розстановка · {editingSlot?.title || 'Деф опонента'}</h2>
                  <p className="mt-0.5 text-[10px] text-foreground-muted">Розмісти рівно 5 героїв на мапі. Зміни не збережуться, доки не натиснеш кнопку внизу.</p>
                </div>
                <button type="button" onClick={closeDefenseEditor} disabled={savingDefense} aria-label="Закрити вікно розстановки" className={buttonClass}>✕</button>
              </div>

              <div className="grid min-w-0 grid-cols-1 gap-0 lg:grid-cols-[minmax(0,1fr)_300px]">
                <section className="relative order-1 flex min-w-0 flex-col justify-center border-b border-surface-border bg-surface-base p-2 pb-2 pt-10 lg:col-start-1 lg:row-start-1 lg:border-b-0 lg:border-r sm:p-3 sm:pt-11">
                  <div className="absolute inset-x-0 top-0 z-30 flex items-start justify-between gap-3 bg-gradient-to-b from-surface-raised/95 to-transparent p-2.5 sm:p-3">
                    <div className="min-w-0">
                      <p className="truncate text-xs font-bold">{activeMap?.name || mapType}</p>
                      <p className="mt-0.5 text-[9px] text-foreground-muted">Герої дефу: {placedHeroCount}/5</p>
                    </div>
                    <span className="shrink-0 rounded-full border border-brand-success/30 bg-brand-success/10 px-2 py-1 text-[9px] font-bold uppercase text-brand-success-hover">{isEditable ? 'Редагування' : 'Лише перегляд'}</span>
                  </div>

                  {activeMap ? (
                    <div className="gvg-map-canvas relative isolate mx-auto my-0 block w-full min-w-0 max-w-[1000px] overflow-hidden rounded-xl border border-surface-border bg-surface-overlay shadow-surface" style={{ aspectRatio: `${currentDim.width} / ${currentDim.height}` }}>
                      <img
                        src={mapType === 'FORT' ? '/images/maps/fort-bg.png' : '/images/maps/tower-bg.png'}
                        alt={activeMap.name || mapType}
                        draggable="false"
                        className="pointer-events-none absolute inset-0 block h-full w-full select-none object-contain"
                      />
                      <div
                        className="pointer-events-none absolute inset-8 flex min-w-0 items-center justify-center transition-transform duration-75"
                        style={{
                          transform: `translate(${currentCalib.offsetX}px, ${currentCalib.offsetY}px) scale(${currentCalib.scale})`,
                          transformOrigin: 'center center',
                          width: `${currentCalib.widthPct}%`,
                          height: `${currentCalib.heightPct}%`,
                        }}
                      >
                        <div className="pointer-events-auto grid h-full w-full" style={{ gridTemplateColumns: `repeat(${activeMap.width}, minmax(0, 1fr))`, gridTemplateRows: `repeat(${activeMap.height}, minmax(0, 1fr))`, gap: '2px' }}>
                          {Array.from({ length: activeMap.height }, (_, y) => Array.from({ length: activeMap.width }, (_, x) => {
                            const tile = mapTileLookup.get(`${x},${y}`);
                            if (!tile || tile.tileType === 'EMPTY') return <div key={`${x}-${y}`} />;
                            const placement = defensePlacementsByTile.get(String(tile.id));
                            const hero = placement ? heroesById.get(String(placement.heroId)) : null;
                            const direction = placement ? getDirection(placement.attackDirection) : null;
                            return (
                              <button
                                key={`${x}-${y}`}
                                type="button"
                                disabled={!isEditable}
                                onClick={() => { if (!placement) placeDefenseHero(tile); }}
                                aria-label={placement ? `${hero?.name || 'Герой'}, клітинка ${x}, ${y}` : `Розмістити героя на клітинці ${x}, ${y}`}
                                title={`X: ${x}, Y: ${y} · ${tile.tileType}`}
                                className={cn('relative flex h-full w-full items-center justify-center rounded-sm border transition-colors disabled:cursor-default', placement ? 'z-10 border-surface-border/80 bg-surface-base/40 shadow-sm' : selectedDefenseHeroId ? 'border-brand-success/70 bg-brand-success/10 hover:bg-brand-success/25' : 'border-surface-border/70 bg-surface-overlay/20 hover:border-brand-accent/60 hover:bg-brand-accent/20')}
                              >
                                {placement && hero && direction ? (
                                  <>
                                    <div
                                      role="button"
                                      tabIndex={isEditable ? 0 : -1}
                                      aria-label={`Повернути напрямок атаки ${hero.name}`}
                                      title={`Напрямок: ${direction.value}. Клікни, щоб повернути на 90°`}
                                      onClick={(event) => { event.preventDefault(); event.stopPropagation(); rotateDefenseHero(placement.heroId); }}
                                      onKeyDown={(event) => { if (event.key === 'Enter' || event.key === ' ') { event.preventDefault(); event.stopPropagation(); rotateDefenseHero(placement.heroId); } }}
                                      className="absolute inset-0.5 z-10 cursor-pointer rounded-sm focus-visible:outline-2 focus-visible:outline-brand-accent"
                                    >
                                      {hero.imageSlug ? <img src={`/images/heroes/${hero.imageSlug}.png`} alt={hero.name} draggable="false" className="h-full w-full select-none rounded-sm object-cover" /> : <span className="flex h-full w-full items-center justify-center bg-surface-sunken text-xs font-bold">{hero.name?.charAt(0)}</span>}
                                      <span
                                        role="button"
                                        tabIndex={isEditable ? 0 : -1}
                                        aria-label="Повернути напрямок"
                                        onClick={(event) => { event.preventDefault(); event.stopPropagation(); rotateDefenseHero(placement.heroId); }}
                                        className={`absolute gvg-map-node-arrow pointer-events-auto flex items-center justify-center rounded-full border border-surface-border bg-surface-raised/95 font-black leading-none text-brand-accent shadow-md ${direction.position}`}
                                        style={{ transform: `rotate(${direction.angle}deg)` }}
                                      >↑</span>
                                    </div>
                                    <span className="pointer-events-none absolute -top-3 left-1/2 z-30 -translate-x-1/2 whitespace-nowrap rounded border border-surface-border bg-surface-sunken/95 px-1 font-bold text-foreground-primary shadow-surface" style={{ fontSize: 'calc(7px * var(--gvg-font-scale))' }}>{hero.name || 'Hero'}</span>
                                    {isEditable ? <span
                                      role="button"
                                      tabIndex={0}
                                      aria-label={`Прибрати ${hero.name} з дефу`}
                                      title="Прибрати героя"
                                      onClick={(event) => { event.preventDefault(); event.stopPropagation(); removeDefenseHero(placement.heroId); }}
                                      onKeyDown={(event) => { if (event.key === 'Enter' || event.key === ' ') { event.preventDefault(); event.stopPropagation(); removeDefenseHero(placement.heroId); } }}
                                      className="absolute -right-1 -top-1 z-40 flex gvg-map-node-close cursor-pointer items-center justify-center rounded-full border border-surface-border bg-surface-sunken font-black leading-none text-brand-danger shadow-md hover:bg-brand-danger hover:text-white"
                                    >×</span> : null}
                                  </>
                                ) : null}
                              </button>
                            );
                          }))}
                        </div>
                      </div>
                    </div>
                  ) : <div className="rounded-xl border border-dashed border-surface-border p-8 text-center text-xs text-foreground-muted">Активну мапу не завантажено.</div>}
                  <p className="mt-2 text-center text-[10px] text-foreground-muted">Вибери героя в каталозі та натисни на клітинку. Натискання на стрілку повертає напрямок, × прибирає героя.</p>
                </section>

                <aside className="order-3 flex min-w-0 flex-col gap-3 bg-surface-raised p-3 lg:col-start-2 lg:row-start-1">
                  <div className="flex items-center justify-between gap-2 border-b border-surface-border pb-2">
                    <h3 className="text-xs font-black uppercase tracking-wide text-brand-accent">Дані ворожого дефу</h3>
                    <span className="text-[9px] text-foreground-muted">{placedHeroCount}/5</span>
                  </div>
                  <div>
                    <label htmlFor="defense-opponent-nickname" className="mb-1 block text-[10px] font-semibold text-foreground-secondary">Нікнейм опонента</label>
                    <input id="defense-opponent-nickname" data-battle-field className={inputClass} value={defenseNickname} maxLength={100} disabled={!isEditable || savingDefense} onChange={(event) => setDefenseNickname(event.target.value)} placeholder="Наприклад, Chekeigata" />
                  </div>
                  <div>
                    <label htmlFor="defense-battle-power" className="mb-1 block text-[10px] font-semibold text-foreground-secondary">Бойова міць (БМ)</label>
                    <input id="defense-battle-power" data-battle-field className={inputClass} type="number" min="0" step="1" value={defenseBattlePower} disabled={!isEditable || savingDefense} onChange={(event) => setDefenseBattlePower(event.target.value)} placeholder="Введи БМ" />
                  </div>
                  <div>
                    <label htmlFor="defense-mirror-note" className="mb-1 block text-[10px] font-semibold text-foreground-secondary">Дзеркало / примітка / посилання</label>
                    <textarea id="defense-mirror-note" data-battle-field className={cn(inputClass, 'min-h-24 resize-y')} rows={4} value={defenseMirrorNote} disabled={!isEditable || savingDefense} onChange={(event) => setDefenseMirrorNote(event.target.value)} placeholder="Посилання на симуляцію або нотатки…" />
                  </div>
                  <div className="rounded-lg border border-surface-border bg-surface-base/70 p-2 text-[10px] text-foreground-muted">
                    <p className="font-semibold text-foreground-secondary">Авто-пошук атак</p>
                    <p className="mt-1">Після збереження п’яти героїв War Room автоматично оновить exact-збіги атак для цього дефу.</p>
                  </div>
                  {defenseModalError ? <p role="alert" className="rounded-lg border border-brand-danger/30 bg-brand-danger/10 p-2 text-[10px] text-brand-danger-hover">{defenseModalError}</p> : null}
                  <div className="mt-auto flex flex-col gap-2 border-t border-surface-border pt-3">
                    <button type="button" disabled={!isEditable || savingDefense} onClick={() => { setDefenseDraft({}); setSelectedDefenseHeroId(null); setDefenseModalError(''); }} className={buttonClass}>Очистити деф</button>
                    <button type="button" disabled={!isEditable || savingDefense || (placedHeroCount !== 0 && placedHeroCount !== 5)} onClick={saveDefenseLayout} className="inline-flex items-center justify-center rounded-lg bg-brand-accent px-3 py-2.5 text-xs font-black text-foreground-onAccent shadow-brand-accent transition hover:bg-brand-accent-hover disabled:cursor-not-allowed disabled:opacity-50">{savingDefense ? 'Збереження…' : placedHeroCount === 0 ? 'Зберегти без дефу' : 'Зберегти розстановку'}</button>
                    <button
                      type="button"
                      disabled={!isEditable || savingDefense || placedHeroCount !== 5}
                      onClick={() => startPresetFromBattle(editingSlot, defenseDraft, {
                        opponentNickname: defenseNickname,
                        battlePower: defenseBattlePower === '' ? null : Number(defenseBattlePower),
                        mirrorNote: defenseMirrorNote,
                      })}
                      className={cn(buttonClass, 'border-brand-accent/50 text-brand-accent hover:bg-brand-accent/10')}
                      title="Скопіювати ці 5 героїв у форму створення атакувального пресету"
                    >Створити пресет з розстановки</button>
                    <p className="text-[9px] leading-snug text-foreground-muted">Перехід перенесе героїв, клітинки та напрямки. Незбережені дані слота битви залишаться незбереженими.</p>
                    <button type="button" disabled={savingDefense} onClick={closeDefenseEditor} className={buttonClass}>Скасувати</button>
                  </div>
                </aside>

                <section className="order-2 min-w-0 border-t border-surface-border bg-surface-raised p-2 lg:col-span-2 lg:row-start-2 sm:p-3">
                  <div className="mb-2 flex flex-col gap-2 xl:flex-row xl:items-center xl:justify-between">
                    <div className="flex flex-wrap items-center gap-2">
                      <h3 className="text-xs font-black uppercase tracking-wider text-brand-accent">Каталог героїв</h3>
                      <span className="rounded-full border border-surface-border bg-surface-sunken px-2 py-0.5 text-[10px] font-semibold text-foreground-muted">{visibleDefenseHeroes.length}</span>
                      {selectedDefenseHeroId ? <span className="rounded-full border border-brand-success/30 bg-brand-success/10 px-2 py-1 text-[10px] font-semibold text-brand-success-hover">Вибери клітинку на мапі</span> : null}
                    </div>
                    <div className="flex min-w-0 flex-wrap items-center gap-1.5">
                      <div className="relative min-w-0 flex-1 sm:flex-none sm:w-40">
                        <input value={defenseSearchQuery} onChange={(event) => setDefenseSearchQuery(event.target.value)} placeholder="Пошук героя…" aria-label="Пошук героя в каталозі дефу" className={cn(inputClass, 'pr-7')} />
                        {(defenseSearchQuery || defenseClassFilter !== 'ALL') ? <button type="button" onClick={() => { setDefenseSearchQuery(''); setDefenseClassFilter('ALL'); }} aria-label="Очистити фільтри героїв" className="absolute right-1 top-1/2 -translate-y-1/2 rounded px-1 text-sm font-black text-brand-danger">×</button> : null}
                      </div>
                      <select value={defenseClassFilter} onChange={(event) => setDefenseClassFilter(event.target.value)} aria-label="Фільтр за класом" className="min-w-0 rounded-lg border border-surface-border bg-surface-sunken px-2 py-1.5 text-[10px] text-foreground-primary">
                        <option value="ALL">Усі класи</option>
                        {heroClasses.map((className) => <option key={className} value={className}>{className}</option>)}
                      </select>
                      <select value={defenseSortBy} onChange={(event) => setDefenseSortBy(event.target.value)} aria-label="Сортування героїв" className="min-w-0 rounded-lg border border-surface-border bg-surface-sunken px-2 py-1.5 text-[10px] text-foreground-primary">
                        <option value="NAME">За ім’ям</option><option value="CLASS">За класом</option>
                      </select>
                      <div className="flex gap-1">
                        <button type="button" onClick={() => scrollDefenseHeroList(-1)} aria-label="Прокрутити героїв ліворуч" className={buttonClass}>←</button>
                        <button type="button" onClick={() => scrollDefenseHeroList(1)} aria-label="Прокрутити героїв праворуч" className={buttonClass}>→</button>
                      </div>
                    </div>
                  </div>
                  {visibleDefenseHeroes.length ? (
                    <div ref={defenseHeroListRef} className="flex gap-2.5 overflow-x-auto pb-2">
                      {visibleDefenseHeroes.map((hero) => {
                        const key = String(hero.id);
                        const placement = defenseDraft[key];
                        const isSelected = String(selectedDefenseHeroId) === key;
                        const isFavorite = favoriteHeroIds.includes(key);
                        const ring = RARITY_RING[String(hero.rarity || '').toUpperCase()] || 'ring-gray-600';
                        return (
                          <div key={hero.id} onClick={() => { if (!isEditable) return; setSelectedDefenseHeroId((current) => String(current) === key ? null : hero.id); setDefenseModalError(''); }} role="button" tabIndex={0} aria-pressed={isSelected} onKeyDown={(event) => { if (event.key === 'Enter' || event.key === ' ') { event.preventDefault(); if (!isEditable) return; setSelectedDefenseHeroId((current) => String(current) === key ? null : hero.id); } }} title={placement ? `${hero.name} · (${placement.x}, ${placement.y})` : `Вибрати ${hero.name}`} className={cn('group relative w-24 flex-shrink-0 cursor-pointer select-none rounded-xl border p-2 text-left transition-colors focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-accent', isSelected ? 'border-brand-accent bg-brand-accent/10 shadow-brand-accent' : placement ? 'border-brand-success/50 bg-brand-success/5' : 'border-surface-border bg-surface-base hover:border-brand-accent/50 hover:bg-surface-sunken', !isEditable && 'cursor-default opacity-75')}>
                            <div className="relative mx-auto h-14 w-14 rounded-lg bg-surface-overlay">
                              {hero.imageSlug ? <img src={`/images/heroes/${hero.imageSlug}.png`} alt={hero.name} draggable="false" className={`h-full w-full rounded-lg object-cover ring-2 ${ring}`} onError={(event) => { event.currentTarget.style.display = 'none'; event.currentTarget.nextElementSibling?.classList.remove('hidden'); }} /> : null}
                              <span className={`${hero.imageSlug ? 'hidden ' : ''}absolute inset-0 flex items-center justify-center rounded-lg bg-surface-sunken text-sm font-black text-brand-accent ring-2 ${ring}`}>{hero.name?.trim()?.charAt(0)?.toUpperCase() || '?'}</span>
                              <button type="button" onClick={(event) => toggleFavoriteHero(hero.id, event)} aria-label={isFavorite ? 'Прибрати з обраних' : 'Додати в обрані'} title={isFavorite ? 'В обраних' : 'Додати в обрані'} className={cn('absolute -left-1 -top-1 flex h-5 w-5 items-center justify-center rounded-full border border-surface-raised text-[10px] transition-transform hover:scale-110', isFavorite ? 'bg-amber-400 font-black text-black' : 'bg-surface-sunken/80 text-foreground-muted hover:text-amber-400')}>★</button>
                              {placement ? <span className="absolute -right-1 -top-1 flex h-4 w-4 items-center justify-center rounded-full border border-surface-raised bg-brand-success text-[9px] font-bold text-white" title={`Позиція (${placement.x}, ${placement.y})`}>✓</span> : null}
                            </div>
                            <p className="mt-2 truncate text-center text-[10px] font-bold">{hero.name}</p>
                            <p className="truncate text-center text-[9px] text-foreground-muted">{hero.className || 'Hero'}</p>
                            {placement ? <p className="mt-1 truncate text-center font-mono text-[9px] text-brand-success-hover">({placement.x},{placement.y})</p> : null}
                          </div>
                        );
                      })}
                    </div>
                  ) : <div className="rounded-xl border border-dashed border-surface-border p-6 text-center text-xs text-foreground-muted">Героїв за вибраними фільтрами не знайдено.</div>}
                </section>
              </div>
            </section>
          </div>
        );
      })() : null}

      {newRoundOpen ? (
        <div className="fixed inset-0 z-[100] flex items-center justify-center bg-black/70 p-3" role="presentation">
          <section role="dialog" aria-modal="true" aria-labelledby="new-round-title" className="w-full max-w-md rounded-xl border border-surface-border bg-surface-raised p-4 shadow-2xl">
            <h2 id="new-round-title" className="text-sm font-black uppercase text-brand-accent">УВАГА!</h2>
            <p className="mt-2 text-xs leading-relaxed text-foreground-secondary">{round ? 'Поточний раунд буде збережено в історію і заблоковано для редагування. Цю дію не можна скасувати.' : 'Буде створено перший раунд битви.'}</p>
            <label className="mt-4 block text-xs font-semibold text-foreground-secondary" htmlFor="new-opponent-name">Введіть назву нового опонента</label>
            <input id="new-opponent-name" autoFocus value={newOpponentName} onChange={(event) => setNewOpponentName(event.target.value)} onKeyDown={(event) => { if (event.key === 'Enter') createNextRound(); }} className={cn(inputClass, 'mt-1.5 px-3 py-2 text-sm')} placeholder="Наприклад, shadow pandas" maxLength={150} />
            <div className="mt-4 flex flex-col-reverse gap-2 sm:flex-row sm:justify-end">
              <button type="button" onClick={() => setNewRoundOpen(false)} className={buttonClass}>Скасувати</button>
              <button type="button" disabled={creatingRound || !newOpponentName.trim()} onClick={createNextRound} className="rounded-lg bg-brand-accent px-3 py-2 text-xs font-black text-foreground-onAccent disabled:opacity-50">{creatingRound ? 'Активація…' : 'Активувати новий раунд'}</button>
            </div>
          </section>
        </div>
      ) : null}

      {renameOpen ? (
        <div className="fixed inset-0 z-[100] flex items-center justify-center bg-black/70 p-3" role="presentation">
          <section role="dialog" aria-modal="true" aria-labelledby="rename-title" className="w-full max-w-sm rounded-xl border border-surface-border bg-surface-raised p-4 shadow-2xl">
            <h2 id="rename-title" className="text-sm font-bold">Змінити назву опонента</h2>
            <input autoFocus value={renameValue} onChange={(event) => setRenameValue(event.target.value)} onKeyDown={(event) => { if (event.key === 'Enter') saveOpponentName(); }} className={cn(inputClass, 'mt-3 px-3 py-2 text-sm')} maxLength={150} />
            <div className="mt-4 flex justify-end gap-2">
              <button type="button" onClick={() => setRenameOpen(false)} className={buttonClass}>Скасувати</button>
              <button type="button" disabled={renaming || !renameValue.trim()} onClick={saveOpponentName} className="rounded-lg bg-brand-accent px-3 py-2 text-xs font-bold text-foreground-onAccent disabled:opacity-50">{renaming ? 'Збереження…' : 'Зберегти'}</button>
            </div>
          </section>
        </div>
      ) : null}

      {historyOpen ? (
        <div className="fixed inset-0 z-[100] flex items-center justify-center bg-black/70 p-3" role="presentation">
          <section role="dialog" aria-modal="true" aria-labelledby="history-title" className="max-h-[85vh] w-full max-w-lg overflow-hidden rounded-xl border border-surface-border bg-surface-raised shadow-2xl">
            <div className="flex items-center justify-between border-b border-surface-border p-3">
              <h2 id="history-title" className="text-sm font-bold">Історія раундів</h2>
              <button type="button" onClick={() => setHistoryOpen(false)} className={buttonClass}>Закрити ×</button>
            </div>
            <div className="max-h-[70vh] space-y-1.5 overflow-y-auto p-3">
              {history.length ? history.map((item) => (
                <button key={item.id} type="button" onClick={() => openHistoricalRound(item.id)} className="flex w-full items-center justify-between gap-3 rounded-lg border border-surface-border bg-surface-base p-3 text-left hover:border-brand-accent/50">
                  <span className="min-w-0"><span className="block text-xs font-bold">Раунд {item.roundNumber} · {item.opponentName}</span><span className="mt-1 block text-[10px] text-foreground-muted">{item.createdAt ? new Date(item.createdAt).toLocaleString() : ''}</span></span>
                  <span className={cn('rounded-full px-2 py-1 text-[9px] font-bold', item.status === 'ACTIVE' ? 'bg-brand-success/10 text-brand-success-hover' : 'bg-red-500/10 text-red-300')}>{item.status === 'ACTIVE' ? 'Активний' : 'Заблокований'}</span>
                </button>
              )) : <p className="p-6 text-center text-xs text-foreground-muted">Історія раундів порожня.</p>}
            </div>
          </section>
        </div>
      ) : null}
    </div>
  );
}
