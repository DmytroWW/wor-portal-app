import { useState } from 'react';
import Header from '../components/layout/Header.jsx';
import GuildPage from './GuildPage';
import UserRoster from './UserRoster';
import AdminPanelPage from './AdminPanelPage';
import GvgPage from './gvg/GvgPage';

const TABS = [
  { id: 'home', label: 'Головна', icon: '🏰' },
  { id: 'heroes', label: 'Мої герої', icon: '🧙‍♂️' },
  { id: 'gvg', label: 'GvG', icon: '⚔️' },
  { id: 'guild', label: 'Менеджмент', icon: '🛡️' },
  { id: 'settings', label: 'Налаштування', icon: '⚙️' },
];

export default function DashboardPage({ user, onLogout, onRefreshUser }) {
  const [activeTab, setActiveTab] = useState('home');
  const isAdmin = user?.role === 'ADMIN';
  const hasGuild = Boolean(user?.guildId || user?.guildName);

  return (
    <div className="min-h-screen bg-surface-base font-base text-foreground-primary selection:bg-brand-secondary selection:text-foreground-primary">
      <Header
        user={user}
        tabs={TABS}
        activeTab={activeTab}
        onTabChange={setActiveTab}
        onLogout={onLogout}
        isAdmin={isAdmin}
      />

      <main className="min-w-0 px-4 pb-8 pt-1 md:px-8 md:pb-8 md:pt-2">
        {activeTab === 'home' && (
          <div className="mx-auto max-w-6xl space-y-6">
            {!hasGuild && (
              <section className="flex flex-col gap-4 rounded-2xl border border-brand-accent/30 bg-gradient-to-r from-surface-raised via-brand-accent/10 to-surface-raised p-5 shadow-surface sm:flex-row sm:items-center sm:justify-between sm:p-6">
                <div className="flex items-start gap-3">
                  <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-xl border border-brand-accent/30 bg-brand-accent/10 text-2xl">🏰</div>
                  <div>
                    <h2 className="font-bold text-foreground-primary">Ти ще не в гільдії</h2>
                    <p className="mt-1 max-w-2xl text-sm text-foreground-muted">Можеш створити власну гільдію або приєднатися до друзів за інвайт-кодом. Це потрібно для спільних GvG-пресетів.</p>
                  </div>
                </div>
                <button type="button" onClick={() => setActiveTab('guild')} className="inline-flex shrink-0 items-center justify-center rounded-lg bg-brand-accent px-4 py-2.5 text-sm font-bold text-foreground-onAccent transition hover:bg-brand-accent-hover">
                  Налаштувати гільдію →
                </button>
              </section>
            )}

            <div className="relative overflow-hidden rounded-2xl border border-brand-secondary/30 bg-gradient-to-r from-surface-raised via-brand-secondary/10 to-surface-raised p-6 shadow-surface md:p-8">
              <div className="flex flex-col items-center justify-between gap-6 md:flex-row">
                <div className="space-y-2">
                  <div className="inline-flex items-center gap-2 rounded-full border border-brand-accent/30 bg-brand-accent/10 px-3 py-1 text-xs font-semibold uppercase text-brand-accent-hover">
                    <span>🔥</span>
                    Привал у таборі • Перепочинок
                  </div>
                  <h2 className="text-2xl font-extrabold text-foreground-primary md:text-3xl">Битви гільдій тимчасово призупинено</h2>
                  <p className="max-w-xl text-sm text-foreground-muted">Мандрівник відпочиває біля вогнища. Відновіть здоров'я своїх героїв та підготуйте оборонні загони.</p>
                </div>
                <div className="min-w-[200px] rounded-xl border border-surface-border bg-surface-overlay/80 p-4 text-center">
                  <p className="mb-1 text-xs font-bold uppercase text-foreground-muted">До наступної війни</p>
                  <p className="text-2xl font-black text-brand-accent-hover">-- : -- : --</p>
                </div>
              </div>
            </div>

            <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
              <div className="card p-6">
                <h3 className="mb-4 flex items-center gap-2 text-lg font-bold text-brand-secondary-hover"><span>🛡️</span>Оголошення офіцерів</h3>
                <div className="space-y-3">
                  <div className="flex justify-between rounded-lg border border-surface-border bg-surface-sunken/40 p-3 text-sm">
                    <div>
                      <p className="font-medium text-foreground-primary">Оновити ростер героїв у профілі</p>
                      <p className="mt-0.5 text-xs text-foreground-muted">Лідер noname_ua</p>
                    </div>
                    <span className="h-fit rounded border border-brand-secondary/40 bg-brand-secondary/20 px-2 py-0.5 text-[10px] font-bold text-brand-secondary-hover">NEW!</span>
                  </div>
                </div>
              </div>
              <div className="card p-6">
                <h3 className="mb-4 flex items-center gap-2 text-lg font-bold text-brand-secondary-hover"><span>📢</span>Новини гільдії</h3>
                <div className="space-y-3">
                  <div className="border-l-2 border-brand-secondary py-1 pl-3 text-sm">
                    <p className="text-foreground-primary">Гільдія успішно завершила фазу підготовки.</p>
                  </div>
                </div>
              </div>
            </div>

            {isAdmin && (
              <button type="button" onClick={() => setActiveTab('admin')} className="group flex w-full items-center justify-between gap-4 rounded-2xl border border-brand-accent/20 bg-gradient-to-r from-surface-raised to-brand-secondary/10 p-5 text-left transition hover:border-brand-accent/50">
                <div className="flex items-center gap-4">
                  <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-brand-accent/10 text-2xl">🛡️</div>
                  <div>
                    <h3 className="font-bold text-brand-accent-hover">Панель адміністратора</h3>
                    <p className="mt-1 text-sm text-foreground-muted">Керування мапами GvG, героями, солдатами та гільдіями.</p>
                  </div>
                </div>
                <span className="text-xl text-brand-accent transition group-hover:translate-x-1">→</span>
              </button>
            )}
          </div>
        )}

        {activeTab === 'guild' && <GuildPage user={user} onRefreshUser={onRefreshUser} />}

        {activeTab === 'heroes' && (
          <div className="mx-auto max-w-6xl">
            <div className="mb-6">
              <h2 className="text-2xl font-extrabold text-brand-secondary-hover">🧙‍♂️ Мої герої</h2>
              <p className="mt-2 text-sm text-foreground-muted">Керуй своїм ростером: натискай ЛКМ для пробудження, ПКМ — щоб видалити героя.</p>
            </div>
            <UserRoster userId={user?.id} />
          </div>
        )}

        {activeTab === 'admin' && isAdmin && <AdminPanelPage user={user} onBack={() => setActiveTab('home')} />}
        {activeTab === 'gvg' && <GvgPage />}
        {activeTab === 'settings' && (
          <div className="flex min-h-[400px] flex-col items-center justify-center space-y-3 text-foreground-muted">
            <span className="text-4xl">🚧</span>
            <p className="text-lg font-semibold">Розділ знаходиться в розробці</p>
          </div>
        )}
      </main>
    </div>
  );
}
