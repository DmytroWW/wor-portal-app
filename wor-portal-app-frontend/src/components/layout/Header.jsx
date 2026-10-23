import { useState } from 'react';

const cn = (...classes) => classes.filter(Boolean).join(' ');

export default function Header({ user, tabs, activeTab, onTabChange, onLogout, isAdmin }) {
  const [mobileOpen, setMobileOpen] = useState(false);

  const handleSelect = (id) => {
    onTabChange(id);
    setMobileOpen(false);
  };

  const handleLogout = () => {
    setMobileOpen(false);
    onLogout?.();
  };

  return (
    <header className="sticky top-0 z-50 w-full shrink-0 border-b border-surface-border bg-surface-raised/95 shadow-sm backdrop-blur-md">
      <div className="mx-auto flex min-h-9 w-full items-center gap-2 px-3 md:min-h-10 md:px-6">
        {/* Logo */}
        <button
          type="button"
          onClick={() => handleSelect('home')}
          className="flex shrink-0 items-center gap-2 rounded-lg px-2 py-1 transition-colors hover:bg-surface-base"
        >
          <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-brand-primary text-lg shadow-sm">
            🏰
          </div>
          <div className="hidden sm:block text-left">
            <div className="text-xs font-bold text-foreground-primary">Guild Manager</div>
            <div className="text-[10px] leading-tight text-foreground-muted">Панель керування</div>
          </div>
        </button>

        {/* Desktop navigation */}
        <nav className="ml-2 hidden min-w-0 flex-1 items-center gap-1 overflow-x-auto md:flex">
          {tabs.map((tab) => {
            const isActive = activeTab === tab.id;
            return (
              <button
                key={tab.id}
                type="button"
                onClick={() => handleSelect(tab.id)}
                className={cn(
                  'flex shrink-0 items-center gap-1.5 rounded-lg px-2.5 py-1.5 text-xs font-medium transition-colors',
                  isActive
                    ? 'bg-brand-primary/10 text-brand-primary'
                    : 'text-foreground-secondary hover:bg-surface-base hover:text-foreground-primary'
                )}
              >
                <span className="text-sm">{tab.icon}</span>
                <span>{tab.label}</span>
              </button>
            );
          })}

          {isAdmin && (
            <button
              type="button"
              onClick={() => handleSelect('admin')}
              className={cn(
                'flex shrink-0 items-center gap-1.5 rounded-lg px-2.5 py-1.5 text-xs font-medium transition-colors',
                activeTab === 'admin'
                  ? 'bg-brand-primary/10 text-brand-primary'
                  : 'text-foreground-secondary hover:bg-surface-base hover:text-foreground-primary'
              )}
            >
              <span className="text-sm">👑</span>
              <span>Адмін</span>
            </button>
          )}
        </nav>

        {/* Desktop user */}
        <div className="ml-auto hidden shrink-0 items-center gap-2 md:flex">
          <div className="flex items-center gap-2 rounded-lg px-2 py-1">
            <div className="flex h-7 w-7 items-center justify-center rounded-full bg-brand-secondary/20 text-xs font-bold text-brand-primary">
              {user?.username?.charAt(0)?.toUpperCase() || 'U'}
            </div>
            <div className="max-w-32 text-left">
              <div className="truncate text-xs font-semibold text-foreground-primary">
                {user?.username || 'Користувач'}
              </div>
              <div className="truncate text-[10px] leading-tight text-foreground-muted">
                {user?.role || 'USER'}
              </div>
            </div>
          </div>

          <button
            type="button"
            onClick={handleLogout}
            className="rounded-lg bg-danger px-3 py-1.5 text-xs font-semibold text-white shadow-lg shadow-brand-danger transition-all hover:bg-danger-hover active:bg-danger-active"
          >
            Вийти
          </button>
        </div>

        {/* Mobile menu button */}
        <button
          type="button"
          onClick={() => setMobileOpen((value) => !value)}
          aria-label={mobileOpen ? 'Закрити меню' : 'Відкрити меню'}
          aria-expanded={mobileOpen}
          className="ml-auto flex h-8 w-8 items-center justify-center rounded-lg text-lg text-foreground-primary transition-colors hover:bg-surface-base md:hidden"
        >
          {mobileOpen ? '✕' : '☰'}
        </button>
      </div>

      {/* Mobile navigation */}
      {mobileOpen && (
        <div className="border-t border-surface-border bg-surface-raised px-4 pb-3 md:hidden">
          <div className="flex items-center gap-2.5 border-b border-surface-border py-2.5">
            <div className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-brand-secondary/20 text-xs font-bold text-brand-primary">
              {user?.username?.charAt(0)?.toUpperCase() || 'U'}
            </div>
            <div className="min-w-0 text-left">
              <div className="truncate text-xs font-semibold text-foreground-primary">
                {user?.username || 'Користувач'}
              </div>
              <div className="text-[10px] text-foreground-muted">
                {user?.role || 'USER'}
              </div>
            </div>
          </div>

          <nav className="flex flex-col gap-1 py-2">
            {tabs.map((tab) => {
              const isActive = activeTab === tab.id;
              return (
                <button
                  key={tab.id}
                  type="button"
                  onClick={() => handleSelect(tab.id)}
                  className={cn(
                    'flex w-full items-center gap-2.5 rounded-lg px-3 py-2 text-left text-xs font-medium transition-colors',
                    isActive
                      ? 'bg-brand-primary/10 text-brand-primary'
                      : 'text-foreground-secondary hover:bg-surface-base hover:text-foreground-primary'
                  )}
                >
                  <span className="text-base">{tab.icon}</span>
                  <span>{tab.label}</span>
                </button>
              );
            })}

            {isAdmin && (
              <button
                type="button"
                onClick={() => handleSelect('admin')}
                className={cn(
                  'flex w-full items-center gap-2.5 rounded-lg px-3 py-2 text-left text-xs font-medium transition-colors',
                  activeTab === 'admin'
                    ? 'bg-brand-primary/10 text-brand-primary'
                    : 'text-foreground-secondary hover:bg-surface-base hover:text-foreground-primary'
                )}
              >
                <span className="text-base">👑</span>
                <span>Адмін</span>
              </button>
            )}
          </nav>

          <button
            type="button"
            onClick={handleLogout}
            className="w-full rounded-lg bg-danger px-3 py-2.5 text-center text-xs font-semibold text-white shadow-lg shadow-brand-danger transition-all hover:bg-danger-hover active:bg-danger-active"
          >
            🚪 Вийти
          </button>
        </div>
      )}
    </header>
  );
}