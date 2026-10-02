import React, { useState } from 'react';
import GuildPage from './GuildPage';
import UserRoster from './UserRoster';

export default function DashboardPage({ user, onLogout }) {
  const [activeTab, setActiveTab] = useState('home');

  return (
    <div className="flex min-h-screen bg-slate-950 text-slate-100 font-sans selection:bg-purple-600 selection:text-white">

      {/* SIDEBAR */}
      <aside className="w-64 bg-slate-900/80 border-r border-slate-800/80 flex flex-col justify-between p-4 backdrop-blur-md">
        <div>
          <div className="flex items-center gap-2 mb-8 px-2">
            <div className="w-8 h-8 rounded-full bg-gradient-to-tr from-purple-600 to-amber-500 flex items-center justify-center font-bold text-slate-950 shadow-lg shadow-purple-900/40">
              W
            </div>
            <h1 className="font-extrabold tracking-wider text-transparent bg-clip-text bg-gradient-to-r from-purple-400 via-purple-200 to-amber-300 text-lg">
              GUILD PORTAL
            </h1>
          </div>

          {/* User Profile */}
          <div className="bg-slate-800/50 border border-slate-700/50 rounded-xl p-3 mb-6 flex items-center gap-3">
            <div className="w-10 h-10 rounded-lg bg-purple-950 border border-purple-500/40 flex items-center justify-center text-purple-300 font-bold text-lg">
              {user?.username?.charAt(0).toUpperCase() || 'U'}
            </div>
            <div className="overflow-hidden">
              <p className="font-bold text-slate-200 truncate">{user?.username}</p>
              <p className="text-xs text-purple-400 font-medium uppercase">
                Status: <span className="text-amber-400">{user?.role || 'MEMBER'}</span>
              </p>
            </div>
          </div>

          {/* Navigation */}
          <nav className="space-y-1.5">
            {[
              { id: 'home', label: 'Головна', icon: '🏰' },
              { id: 'heroes', label: 'Мої герої', icon: '🧙‍♂️' },
              { id: 'gvg', label: 'GvG', icon: '⚔️' },
              { id: 'guild', label: 'Менеджмент', icon: '🛡️' },
              { id: 'settings', label: 'Налаштування', icon: '⚙️' },
            ].map((tab) => (
              <button
                key={tab.id}
                onClick={() => setActiveTab(tab.id)}
                className={`w-full flex items-center gap-3 px-3.5 py-2.5 rounded-lg text-sm font-semibold transition cursor-pointer ${
                  activeTab === tab.id
                    ? 'bg-purple-900/40 text-purple-200 border border-purple-500/50 shadow-lg shadow-purple-950/50'
                    : 'text-slate-400 hover:text-slate-200 hover:bg-slate-800/40'
                }`}
              >
                <span className="text-lg">{tab.icon}</span> {tab.label}
              </button>
            ))}
          </nav>
        </div>

        <button
          onClick={onLogout}
          className="w-full flex items-center gap-3 px-3.5 py-2.5 rounded-lg text-sm font-semibold text-red-400 hover:bg-red-500/10 transition cursor-pointer"
        >
          <span className="text-lg">🚪</span> Вихід
        </button>
      </aside>

      {/* MAIN CONTENT */}
      <main className="flex-1 p-8 overflow-y-auto">
        {/* ГОЛОВНА ВКЛАДКА */}
        {activeTab === 'home' && (
          <div className="space-y-6 max-w-6xl mx-auto">
            {/* Banner */}
            <div className="relative rounded-2xl overflow-hidden border border-purple-500/30 bg-gradient-to-r from-slate-900 via-purple-950/40 to-slate-900 p-8 shadow-2xl">
              <div className="flex flex-col md:flex-row items-center justify-between gap-6">
                <div className="space-y-2">
                  <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-amber-500/10 border border-amber-500/30 text-amber-300 text-xs font-semibold uppercase">
                    <span>🔥</span> Привал у таборі • Перепочинок
                  </div>
                  <h2 className="text-3xl font-extrabold text-slate-100">Битви гільдій тимчасово призупинено</h2>
                  <p className="text-slate-400 text-sm max-w-xl">
                    Мандрівник відпочиває біля вогнища. Відновіть здоров'я своїх героїв та підготуйте оборонні загони.
                  </p>
                </div>
                <div className="bg-slate-900/80 border border-slate-700/60 rounded-xl p-4 text-center min-w-[200px]">
                  <p className="text-xs font-bold text-slate-400 uppercase mb-1">До наступної війни</p>
                  <p className="text-2xl font-black text-amber-400">-- : -- : --</p>
                </div>
              </div>
            </div>

            {/* Bottom Grid */}
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              <div className="bg-slate-900/60 border border-slate-800 rounded-xl p-6 shadow-lg">
                <h3 className="font-bold text-lg text-purple-200 mb-4 flex items-center gap-2"><span>🛡️</span> Оголошення офіцерів</h3>
                <div className="space-y-3">
                  <div className="bg-slate-800/40 border border-slate-700/40 rounded-lg p-3 text-sm flex justify-between">
                    <div>
                      <p className="text-slate-200 font-medium">Оновити ростер героїв у профілі</p>
                      <p className="text-xs text-slate-400 mt-0.5">Лідер noname_ua</p>
                    </div>
                    <span className="bg-purple-500/20 text-purple-300 text-[10px] font-bold px-2 py-0.5 rounded border border-purple-500/40">NEW!</span>
                  </div>
                </div>
              </div>

              <div className="bg-slate-900/60 border border-slate-800 rounded-xl p-6 shadow-lg">
                <h3 className="font-bold text-lg text-purple-200 mb-4 flex items-center gap-2"><span>📢</span> Новини гільдії</h3>
                <div className="space-y-3">
                  <div className="text-sm border-l-2 border-purple-500 pl-3 py-1">
                    <p className="text-slate-200">Гільдія успішно завершила фазу підготовки.</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        )}

        {/* ВКЛАДКА ГІЛЬДІЯ */}
        {activeTab === 'guild' && <GuildPage user={user} />}

        {/* ВКЛАДКА МОЇ ГЕРОЇ */}
        {activeTab === 'heroes' && (
          <div className="max-w-6xl mx-auto">
            <div className="mb-6">
              <h2 className="text-2xl font-extrabold text-purple-200">
                🧙‍♂️ Мої герої
              </h2>
              <p className="text-sm text-slate-400 mt-2">
                Керуй своїм ростером: натискай ЛКМ для пробудження,
                ПКМ — щоб видалити героя.
              </p>
            </div>

            <UserRoster userId={user?.id} />
          </div>
        )}

        {/* ЗАГЛУШКИ ДЛЯ ІНШИХ ВКЛАДОК */}
        {['gvg', 'settings'].includes(activeTab) && (
          <div className="flex flex-col items-center justify-center h-full text-slate-400 space-y-3">
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