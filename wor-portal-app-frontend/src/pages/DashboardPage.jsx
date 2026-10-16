import React, { useState } from 'react';
import GuildPage from './GuildPage';
import UserRoster from './UserRoster';
import AdminPanelPage from './AdminPanelPage';

import GvgPage from './gvg/GvgPage';

export default function DashboardPage({ user, onLogout }) {
  const [activeTab, setActiveTab] = useState('home');

  const isAdmin = user?.role === 'ADMIN';

  const tabs = [
    { id: 'home', label: 'Головна', icon: '🏰' },
    { id: 'heroes', label: 'Мої герої', icon: '🧙‍♂️' },
    { id: 'gvg', label: 'GvG', icon: '⚔️' },
    { id: 'guild', label: 'Менеджмент', icon: '🛡️' },
    { id: 'settings', label: 'Налаштування', icon: '⚙️' },
  ];

  return (
    <div className="flex min-h-screen bg-slate-950 font-sans text-slate-100 selection:bg-purple-600 selection:text-white">

      {/* SIDEBAR */}
      <aside className="flex w-64 shrink-0 flex-col justify-between border-r border-slate-800/80 bg-slate-900/80 p-4 backdrop-blur-md">
        <div>
          {/* LOGO */}
          <div className="mb-8 flex items-center gap-2 px-2">
            <div className="flex h-8 w-8 items-center justify-center rounded-full bg-gradient-to-tr from-purple-600 to-amber-500 font-bold text-slate-950 shadow-lg shadow-purple-900/40">
              W
            </div>

            <h1 className="bg-gradient-to-r from-purple-400 via-purple-200 to-amber-300 bg-clip-text text-lg font-extrabold tracking-wider text-transparent">
              GUILD PORTAL
            </h1>
          </div>

          {/* USER PROFILE */}
          <div className="mb-6 flex items-center gap-3 rounded-xl border border-slate-700/50 bg-slate-800/50 p-3">
            <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg border border-purple-500/40 bg-purple-950 text-lg font-bold text-purple-300">
              {user?.username?.charAt(0).toUpperCase() || 'U'}
            </div>

            <div className="overflow-hidden">
              <p className="truncate font-bold text-slate-200">
                {user?.username || 'Користувач'}
              </p>

              <p className="text-xs font-medium uppercase text-purple-400">
                Status:{' '}
                <span className="text-amber-400">
                  {user?.role || 'MEMBER'}
                </span>
              </p>
            </div>
          </div>

          {/* MAIN NAVIGATION */}
          <nav className="space-y-1.5">
            {tabs.map((tab) => (
              <button
                key={tab.id}
                onClick={() => setActiveTab(tab.id)}
                className={`flex w-full cursor-pointer items-center gap-3 rounded-lg border px-3.5 py-2.5 text-sm font-semibold transition ${
                  activeTab === tab.id
                    ? 'border-purple-500/50 bg-purple-900/40 text-purple-200 shadow-lg shadow-purple-950/50'
                    : 'border-transparent text-slate-400 hover:bg-slate-800/40 hover:text-slate-200'
                }`}
              >
                <span className="text-lg">{tab.icon}</span>
                {tab.label}
              </button>
            ))}

            {/* ADMIN PANEL — ONLY FOR ADMIN */}
            {isAdmin && (
              <div className="my-4 border-t border-slate-800 pt-4">
                <p className="mb-2 px-3.5 text-[10px] font-bold uppercase tracking-[0.2em] text-amber-400/70">
                  Адміністрування
                </p>

                <button
                  onClick={() => setActiveTab('admin')}
                  className={`flex w-full cursor-pointer items-center gap-3 rounded-lg border px-3.5 py-3 text-sm font-bold transition ${
                    activeTab === 'admin'
                      ? 'border-amber-500/50 bg-gradient-to-r from-purple-900/60 to-amber-900/20 text-amber-200 shadow-lg shadow-amber-950/20'
                      : 'border-amber-500/20 bg-slate-800/40 text-amber-300 hover:border-amber-500/50 hover:bg-slate-800'
                  }`}
                >
                  <span className="text-lg">🛡️</span>
                  Admin Panel
                  <span className="ml-auto text-xs">→</span>
                </button>
              </div>
            )}
          </nav>
        </div>

        {/* LOGOUT */}
        <button
          onClick={onLogout}
          className="flex w-full cursor-pointer items-center gap-3 rounded-lg px-3.5 py-2.5 text-sm font-semibold text-red-400 transition hover:bg-red-500/10"
        >
          <span className="text-lg">🚪</span>
          Вихід
        </button>
      </aside>

      {/* MAIN CONTENT */}
      <main className="min-w-0 flex-1 overflow-y-auto p-8">

        {/* HOME */}
        {activeTab === 'home' && (
          <div className="mx-auto max-w-6xl space-y-6">

            {/* BANNER */}
            <div className="relative overflow-hidden rounded-2xl border border-purple-500/30 bg-gradient-to-r from-slate-900 via-purple-950/40 to-slate-900 p-8 shadow-2xl">
              <div className="flex flex-col items-center justify-between gap-6 md:flex-row">
                <div className="space-y-2">
                  <div className="inline-flex items-center gap-2 rounded-full border border-amber-500/30 bg-amber-500/10 px-3 py-1 text-xs font-semibold uppercase text-amber-300">
                    <span>🔥</span>
                    Привал у таборі • Перепочинок
                  </div>

                  <h2 className="text-3xl font-extrabold text-slate-100">
                    Битви гільдій тимчасово призупинено
                  </h2>

                  <p className="max-w-xl text-sm text-slate-400">
                    Мандрівник відпочиває біля вогнища. Відновіть здоров&apos;я
                    своїх героїв та підготуйте оборонні загони.
                  </p>
                </div>

                <div className="min-w-[200px] rounded-xl border border-slate-700/60 bg-slate-900/80 p-4 text-center">
                  <p className="mb-1 text-xs font-bold uppercase text-slate-400">
                    До наступної війни
                  </p>
                  <p className="text-2xl font-black text-amber-400">
                    -- : -- : --
                  </p>
                </div>
              </div>
            </div>

            {/* BOTTOM GRID */}
            <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">

              {/* OFFICER ANNOUNCEMENTS */}
              <div className="rounded-xl border border-slate-800 bg-slate-900/60 p-6 shadow-lg">
                <h3 className="mb-4 flex items-center gap-2 text-lg font-bold text-purple-200">
                  <span>🛡️</span>
                  Оголошення офіцерів
                </h3>

                <div className="space-y-3">
                  <div className="flex justify-between rounded-lg border border-slate-700/40 bg-slate-800/40 p-3 text-sm">
                    <div>
                      <p className="font-medium text-slate-200">
                        Оновити ростер героїв у профілі
                      </p>
                      <p className="mt-0.5 text-xs text-slate-400">
                        Лідер noname_ua
                      </p>
                    </div>

                    <span className="h-fit rounded border border-purple-500/40 bg-purple-500/20 px-2 py-0.5 text-[10px] font-bold text-purple-300">
                      NEW!
                    </span>
                  </div>
                </div>
              </div>

              {/* GUILD NEWS */}
              <div className="rounded-xl border border-slate-800 bg-slate-900/60 p-6 shadow-lg">
                <h3 className="mb-4 flex items-center gap-2 text-lg font-bold text-purple-200">
                  <span>📢</span>
                  Новини гільдії
                </h3>

                <div className="space-y-3">
                  <div className="border-l-2 border-purple-500 py-1 pl-3 text-sm">
                    <p className="text-slate-200">
                      Гільдія успішно завершила фазу підготовки.
                    </p>
                  </div>
                </div>
              </div>
            </div>

            {/* ADMIN SHORTCUT */}
            {isAdmin && (
              <button
                onClick={() => setActiveTab('admin')}
                className="group flex w-full items-center justify-between gap-4 rounded-2xl border border-amber-500/20 bg-gradient-to-r from-slate-900 to-purple-950/30 p-5 text-left transition hover:border-amber-500/50"
              >
                <div className="flex items-center gap-4">
                  <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-amber-500/10 text-2xl">
                    🛡️
                  </div>

                  <div>
                    <h3 className="font-bold text-amber-200">
                      Панель адміністратора
                    </h3>
                    <p className="mt-1 text-sm text-slate-400">
                      Керування мапами GvG, героями, солдатами та гільдіями.
                    </p>
                  </div>
                </div>

                <span className="text-xl text-amber-400 transition group-hover:translate-x-1">
                  →
                </span>
              </button>
            )}
          </div>
        )}

        {/* GUILD MANAGEMENT */}
        {activeTab === 'guild' && <GuildPage user={user} />}

        {/* USER HEROES */}
        {activeTab === 'heroes' && (
          <div className="mx-auto max-w-6xl">
            <div className="mb-6">
              <h2 className="text-2xl font-extrabold text-purple-200">
                🧙‍♂️ Мої герої
              </h2>

              <p className="mt-2 text-sm text-slate-400">
                Керуй своїм ростером: натискай ЛКМ для пробудження,
                ПКМ — щоб видалити героя.
              </p>
            </div>

            <UserRoster userId={user?.id} />
          </div>
        )}

        {/* ADMIN PANEL */}
        {activeTab === 'admin' && isAdmin && (
          <AdminPanelPage
            user={user}
            onBack={() => setActiveTab('home')}
          />
        )}

        {/* GVG */}
        {activeTab === 'gvg' && <GvgPage />}

        {/* SETTINGS */}
        {activeTab === 'settings' && (
          <div className="flex h-full min-h-[400px] flex-col items-center justify-center space-y-3 text-slate-400">
            <span className="text-4xl">🚧</span>

            <p className="text-lg font-semibold">
              Розділ знаходиться в розробці
            </p>
          </div>
        )}
      </main>
    </div>
  );
}