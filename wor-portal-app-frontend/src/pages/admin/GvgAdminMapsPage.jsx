
import { useCallback, useEffect, useMemo, useState } from 'react';
import api from '../../api/axios';

const MAP_SIZES = {
  FORT: { width: 11, height: 8 },
  TOWER: { width: 10, height: 7 },
};

const TILE_TYPES = [
  { value: 'GROUND', label: 'Земля', color: 'bg-emerald-700', selected: 'ring-emerald-300' },
  { value: 'PLATFORM', label: 'Платформа', color: 'bg-amber-600', selected: 'ring-amber-300' },
  { value: 'EMPTY', label: 'Порожньо', color: 'bg-slate-700', selected: 'ring-slate-300' },
];

const errorMessage = (error) =>
  error?.response?.data?.message ||
  error?.response?.data?.error ||
  error?.message ||
  'Сталася помилка запиту.';

export default function GvgAdminMapsPage() {
  const [maps, setMaps] = useState([]);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState('');
  const [notice, setNotice] = useState('');
  const [selectedMap, setSelectedMap] = useState(null);
  const [tiles, setTiles] = useState([]);
  const [activeTileType, setActiveTileType] = useState('GROUND');
  const [dirtyTiles, setDirtyTiles] = useState({});
  const [form, setForm] = useState({
    seasonNumber: '1',
    mapType: 'FORT',
    name: '',
  });

  const loadMaps = useCallback(async () => {
    setLoading(true);
    setError('');

    try {
      const response = await api.get('/gvg/maps');
      setMaps(Array.isArray(response.data) ? response.data : []);
    } catch (err) {
      setError(errorMessage(err));
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    loadMaps();
  }, [loadMaps]);

  const loadTiles = async (map) => {
    setError('');
    setNotice('');
    setSelectedMap(map);
    setDirtyTiles({});

    try {
      const response = await api.get(`/gvg/maps/${map.id}/tiles`);
      setTiles(Array.isArray(response.data) ? response.data : []);
    } catch (err) {
      setTiles([]);
      setError(errorMessage(err));
    }
  };

  const createMap = async (event) => {
    event.preventDefault();
    setError('');
    setNotice('');
    setSaving(true);

    try {
      await api.post('/gvg/admin/maps', {
        seasonNumber: Number(form.seasonNumber),
        mapType: form.mapType,
        name: form.name.trim(),
        active: false,
      });

      setNotice('Мапу створено. Вона неактивна, доки ти не активуєш її окремо.');
      setForm((current) => ({ ...current, name: '' }));
      await loadMaps();
    } catch (err) {
      setError(errorMessage(err));
    } finally {
      setSaving(false);
    }
  };

  const dimensions = selectedMap
    ? MAP_SIZES[selectedMap.mapType]
    : MAP_SIZES[form.mapType];

  const tileLookup = useMemo(() => {
    const lookup = new Map();

    for (const tile of tiles) {
      lookup.set(`${tile.x},${tile.y}`, tile);
    }

    return lookup;
  }, [tiles]);

  const updateTile = (x, y) => {
    const tile = tileLookup.get(`${x},${y}`);

    if (!tile) {
      setError(`Не знайдено клітинку (${x}, ${y}) у відповіді API.`);
      return;
    }

    setDirtyTiles((current) => ({
      ...current,
      [`${x},${y}`]: {
        x,
        y,
        tileType: activeTileType,
      },
    }));

    setTiles((current) =>
      current.map((item) =>
        item.x === x && item.y === y
          ? { ...item, tileType: activeTileType }
          : item,
      ),
    );
  };

  const saveTiles = async () => {
    if (!selectedMap || Object.keys(dirtyTiles).length === 0) return;

    setSaving(true);
    setError('');
    setNotice('');

    try {
      await api.put(`/gvg/admin/maps/${selectedMap.id}/tiles`, {
        tiles: Object.values(dirtyTiles),
      });

      setDirtyTiles({});
      setNotice('Зміни сітки збережено.');
      await loadTiles(selectedMap);
    } catch (err) {
      setError(errorMessage(err));
    } finally {
      setSaving(false);
    }
  };

  const activateMap = async (map) => {
    const confirmed = window.confirm(
      `Активувати мапу «${map.name}»? Активна мапа цього типу буде замінена.`,
    );

    if (!confirmed) return;

    setSaving(true);
    setError('');
    setNotice('');

    try {
      await api.put(`/gvg/admin/maps/${map.id}/activate`);
      setNotice(`Мапу «${map.name}» активовано.`);
      await loadMaps();
    } catch (err) {
      setError(errorMessage(err));
    } finally {
      setSaving(false);
    }
  };

  const closeEditor = () => {
    setSelectedMap(null);
    setTiles([]);
    setDirtyTiles({});
    setError('');
    setNotice('');
  };

  return (
    <div className="space-y-8">
      <header>
        <p className="text-sm font-semibold uppercase tracking-widest text-violet-400">
          Адміністрування / GvG
        </p>
        <h1 className="mt-2 text-3xl font-bold">Мапи</h1>
        <p className="mt-2 text-sm text-slate-400">
          Створюй мапи сезонів, налаштовуй клітинки та активуй потрібну версію.
        </p>
      </header>

      {error && (
        <div role="alert" className="rounded-xl border border-red-500/30 bg-red-500/10 p-4 text-sm text-red-300">
          {error}
        </div>
      )}

      {notice && (
        <div role="status" className="rounded-xl border border-emerald-500/30 bg-emerald-500/10 p-4 text-sm text-emerald-300">
          {notice}
        </div>
      )}

      <section className="rounded-2xl border border-slate-800 bg-slate-900 p-5">
        <h2 className="text-xl font-bold">Створити мапу</h2>

        <form onSubmit={createMap} className="mt-5 grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
          <label className="text-sm text-slate-300">
            Сезон
            <input
              type="number"
              min="1"
              required
              value={form.seasonNumber}
              onChange={(event) => setForm({ ...form, seasonNumber: event.target.value })}
              className="mt-2 w-full rounded-lg border border-slate-700 bg-slate-950 px-3 py-2.5 text-white outline-none focus:border-violet-500"
            />
          </label>

          <label className="text-sm text-slate-300">
            Тип мапи
            <select
              value={form.mapType}
              onChange={(event) => setForm({ ...form, mapType: event.target.value })}
              className="mt-2 w-full rounded-lg border border-slate-700 bg-slate-950 px-3 py-2.5 text-white outline-none focus:border-violet-500"
            >
             <option value="FORT">FORT — 11 × 8</option>
             <option value="TOWER">TOWER — 10 × 7</option>
            </select>
          </label>

          <label className="text-sm text-slate-300 sm:col-span-2">
            Назва
            <input
              type="text"
              required
              maxLength={100}
              value={form.name}
              onChange={(event) => setForm({ ...form, name: event.target.value })}
              placeholder="Наприклад, Season 1 — Fort"
              className="mt-2 w-full rounded-lg border border-slate-700 bg-slate-950 px-3 py-2.5 text-white outline-none focus:border-violet-500"
            />
          </label>

          <div className="flex items-end justify-between gap-3 sm:col-span-2 xl:col-span-4">
            <p className="text-sm text-slate-400">
              Розмір: {MAP_SIZES[form.mapType].width} × {MAP_SIZES[form.mapType].height}.
              Нову мапу буде створено неактивною.
            </p>
            <button
              type="submit"
              disabled={saving}
              className="shrink-0 rounded-xl bg-violet-600 px-5 py-3 font-semibold hover:bg-violet-500 disabled:opacity-50"
            >
              {saving ? 'Обробка…' : '＋ Створити'}
            </button>
          </div>
        </form>
      </section>

      <section className="space-y-4">
        <div className="flex flex-wrap items-center justify-between gap-3">
          <h2 className="text-xl font-bold">Список мап</h2>
          <button
            onClick={loadMaps}
            disabled={loading}
            className="rounded-lg border border-slate-700 px-3 py-2 text-sm hover:bg-slate-800 disabled:opacity-50"
          >
            ↻ Оновити
          </button>
        </div>

        {loading ? (
          <p className="py-8 text-center text-slate-400">Завантаження мап…</p>
        ) : maps.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-slate-700 p-8 text-center text-slate-400">
            Мап поки немає. Створи першу за допомогою форми вище.
          </div>
        ) : (
          <div className="grid gap-4 xl:grid-cols-2">
            {maps.map((map) => (
              <article
                key={map.id}
                className="rounded-2xl border border-slate-800 bg-slate-900 p-5"
              >
                <div className="flex flex-wrap items-start justify-between gap-3">
                  <div>
                    <p className="text-xs font-semibold uppercase tracking-wider text-violet-400">
                      Сезон {map.seasonNumber} · {map.mapType}
                    </p>
                    <h3 className="mt-2 text-lg font-bold">{map.name}</h3>
                    <p className="mt-1 text-sm text-slate-400">
                      {map.width} × {map.height} · ID: {map.id}
                    </p>
                  </div>

                  <span className={`rounded-full px-3 py-1 text-xs font-semibold ${
                    map.active
                      ? 'bg-emerald-500/15 text-emerald-300'
                      : 'bg-slate-700 text-slate-300'
                  }`}>
                    {map.active ? 'Активна' : 'Неактивна'}
                  </span>
                </div>

                <div className="mt-5 flex flex-wrap gap-2">
                  <button
                    onClick={() => loadTiles(map)}
                    className="rounded-lg bg-violet-600 px-4 py-2 text-sm font-semibold hover:bg-violet-500"
                  >
                    Редагувати сітку
                  </button>
                  {!map.active && (
                    <button
                      onClick={() => activateMap(map)}
                      disabled={saving}
                      className="rounded-lg border border-emerald-500/40 px-4 py-2 text-sm font-semibold text-emerald-300 hover:bg-emerald-500/10 disabled:opacity-50"
                    >
                      Активувати
                    </button>
                  )}
                </div>
              </article>
            ))}
          </div>
        )}
      </section>

      {selectedMap && (
        <section className="rounded-2xl border border-slate-700 bg-slate-900 p-4 sm:p-6">
          <div className="flex flex-wrap items-start justify-between gap-3">
            <div>
              <p className="text-sm text-violet-400">Редактор мапи</p>
              <h2 className="mt-1 text-xl font-bold">{selectedMap.name}</h2>
              <p className="mt-1 text-sm text-slate-400">
                Обери тип клітинки, потім натискай на клітинки сітки.
              </p>
            </div>
            <button onClick={closeEditor} className="rounded-lg border border-slate-700 px-3 py-2 text-sm hover:bg-slate-800">
              Закрити
            </button>
          </div>

          <div className="mt-5 flex flex-wrap gap-2">
            {TILE_TYPES.map((tileType) => (
              <button
                key={tileType.value}
                onClick={() => setActiveTileType(tileType.value)}
                className={`flex items-center gap-2 rounded-lg border px-3 py-2 text-sm ${
                  activeTileType === tileType.value
                    ? 'border-white ring-2 ring-violet-400'
                    : 'border-slate-700'
                }`}
              >
                <span className={`h-4 w-4 rounded ${tileType.color}`} />
                {tileType.label}
              </button>
            ))}
          </div>

          <div className="mt-6 overflow-x-auto pb-3">
            <div
              className="mx-auto grid w-max gap-1"
              style={{ gridTemplateColumns: `repeat(${dimensions.width}, minmax(30px, 1fr))` }}
            >
              {Array.from({ length: dimensions.height }, (_, y) =>
                Array.from({ length: dimensions.width }, (_, x) => {
                  const tile = tileLookup.get(`${x},${y}`);
                  const tileType = dirtyTiles[`${x},${y}`]?.tileType ?? tile?.tileType ?? 'EMPTY';
                  const tileStyle = TILE_TYPES.find((item) => item.value === tileType);

                  return (
                    <button
                      key={`${x}-${y}`}
                      type="button"
                      title={`X: ${x}, Y: ${y} · ${tileType}`}
                      aria-label={`Клітинка ${x}, ${y}: ${tileType}`}
                      onClick={() => updateTile(x, y)}
                      disabled={!tile || saving}
                      className={`flex h-9 w-9 items-center justify-center rounded text-[10px] font-bold text-white sm:h-10 sm:w-10 ${tileStyle?.color ?? 'bg-slate-700'} ${!tile ? 'opacity-40' : 'hover:ring-2 hover:ring-white'} disabled:cursor-not-allowed`}
                    >
                      {tile ? (tileType === 'GROUND' ? 'G' : tileType === 'PLATFORM' ? 'P' : '·') : '?'}
                    </button>
                  );
                }),
              )}
            </div>
          </div>

          <div className="mt-3 flex flex-wrap items-center justify-between gap-3">
            <p className="text-sm text-slate-400">
              Змінено клітинок: {Object.keys(dirtyTiles).length}
            </p>
            <button
              onClick={saveTiles}
              disabled={saving || Object.keys(dirtyTiles).length === 0}
              className="rounded-xl bg-emerald-600 px-5 py-3 font-semibold hover:bg-emerald-500 disabled:cursor-not-allowed disabled:opacity-50"
            >
              {saving ? 'Збереження…' : 'Зберегти сітку'}
            </button>
          </div>
        </section>
      )}
    </div>
  );
}
