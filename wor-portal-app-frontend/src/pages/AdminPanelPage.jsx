
import { useState } from 'react';
import GvgAdminMapsPage from './admin/GvgAdminMapsPage';

const sections = [
  { id: 'overview', label: 'Огляд', icon: '📊' },
  { id: 'maps', label: 'GvG — Мапи', icon: '🗺️' },
  { id: 'heroes', label: 'Герої', icon: '⚔️' },
  { id: 'soldiers', label: 'Демонічні солдати', icon: '👹' },
  { id: 'guilds', label: 'Гільдії', icon: '🏰' },
  { id: 'users', label: 'Користувачі', icon: '👥' },
];

export default function AdminPanelPage({ user, onBack }) {
  const [section, setSection] = useState('overview');

  if (user?.role !== 'ADMIN') {
    return (
      <div className="rounded-2xl border border-red-500/30 bg-slate-900 p-8 text-center text-red-300">
        <h2 className="text-xl font-bold">Доступ заборонено</h2>
        <p className="mt-2 text-sm">Цей розділ доступний лише адміністраторам.</p>
        <button
          onClick={onBack}
          className="mt-5 rounded-lg bg-slate-700 px-4 py-2 text-white hover:bg-slate-600"
        >
          Повернутися
        </button>
      </div>
    );
  }

  const placeholders = {
    heroes: {
      title: 'Керування героями',
      description: 'Тут буде додавання, редагування та видалення героїв.',
    },
    soldiers: {
      title: 'Демонічні солдати',
      description: 'Тут буде керування каталогом демонічних солдатів.',
    },
    guilds: {
      title: 'Керування гільдіями',
      description: 'Тут буде перегляд і адміністрування гільдій.',
    },
    users: {
      title: 'Керування користувачами',
      description: 'Тут будуть доступні адміністративні операції з користувачами.',
    },
  };

  return (
    <div className="flex min-h-[650px] flex-col overflow-hidden rounded-2xl border border-slate-700 bg-slate-950 text-white lg:flex-row">
      <aside className="w-full shrink-0 border-b border-slate-800 bg-slate-900 p-4 lg:w-64 lg:border-b-0 lg:border-r">
        <div className="mb-6 flex items-center gap-3 px-2 pt-2">
          <div className="flex h-11 w-11 items-center justify-center rounded-xl bg-violet-500/15 text-2xl">
            🛡️
          </div>
          <div>
            <h2 className="font-bold">Admin Panel</h2>
            <p className="text-xs text-slate-400">WoR Portal</p>
          </div>
        </div>

        <nav className="flex flex-wrap gap-2 lg:flex-col">
          {sections.map((item) => (
            <button
              key={item.id}
              onClick={() => setSection(item.id)}
              className={`flex items-center gap-3 rounded-xl px-3 py-3 text-left text-sm transition ${
                section === item.id
                  ? 'bg-violet-600 text-white'
                  : 'text-slate-300 hover:bg-slate-800 hover:text-white'
              }`}
            >
              <span>{item.icon}</span>
              <span>{item.label}</span>
            </button>
          ))}
        </nav>

        <button
          onClick={onBack}
          className="mt-6 w-full rounded-xl border border-slate-700 px-3 py-3 text-sm text-slate-300 hover:bg-slate-800"
        >
          ← До основного меню
        </button>
      </aside>

      <main className="min-w-0 flex-1 p-4 sm:p-6 lg:p-8">
        {section === 'maps' ? (
          <GvgAdminMapsPage />
        ) : section === 'overview' ? (
          <div>
            <p className="text-sm font-semibold uppercase tracking-widest text-violet-400">
              Адміністрування
            </p>
            <h1 className="mt-2 text-3xl font-bold">Панель керування</h1>
            <p className="mt-3 text-slate-400">
              Обери розділ, щоб керувати контентом і налаштуваннями WoR Portal.
            </p>

            <div className="mt-8 grid gap-4 sm:grid-cols-2 xl:grid-cols-3">
              {sections.filter((item) => item.id !== 'overview').map((item) => (
                <button
                  key={item.id}
                  onClick={() => setSection(item.id)}
                  className="rounded-2xl border border-slate-800 bg-slate-900 p-5 text-left transition hover:border-violet-500/60 hover:bg-slate-800"
                >
                  <span className="text-3xl">{item.icon}</span>
                  <h3 className="mt-4 font-semibold">{item.label}</h3>
                  <p className="mt-2 text-sm text-slate-400">
                    Відкрити розділ керування
                  </p>
                </button>
              ))}
            </div>
          </div>
        ) : (
          <div className="flex min-h-80 flex-col items-center justify-center text-center">
            <span className="text-5xl">{sections.find((item) => item.id === section)?.icon}</span>
            <h1 className="mt-5 text-2xl font-bold">
              {placeholders[section]?.title}
            </h1>
            <p className="mt-3 max-w-md text-slate-400">
              {placeholders[section]?.description}
            </p>
            <p className="mt-5 rounded-lg border border-amber-500/20 bg-amber-500/10 px-4 py-2 text-sm text-amber-300">
              Розділ буде реалізовано наступним етапом.
            </p>
          </div>
        )}
      </main>
    </div>
  );
}
