import React, { useState } from 'react';
import GvGCreatePresetPage from "./GvgCreatePresetPage";
import GvGSearchPresetPage from "./GvgSearchPresetPage";
import GvGBattlePage from "./GvgBattlePage";

export default function GvGPage() {
  const [currentView, setCurrentView] = useState('hub'); // 'hub' | 'search' | 'create' | 'battle'


  // Перехід на сторінку поточної битви GvG
  if (currentView === 'battle') {
    return (
      <GvGBattlePage
        onBack={() => setCurrentView('hub')}
        onCreatePreset={() => setCurrentView('create')}
      />
    );
  }

  // Перехід на сторінку пошуку пресетів
  if (currentView === 'search') {
    return <GvGSearchPresetPage onBack={() => setCurrentView('hub')} />;
  }

  // Перехід на сторінку створення пресету
  if (currentView === 'create') {
    return (
      <GvGCreatePresetPage
        onBack={() => setCurrentView('hub')}
        onBackToBattle={() => setCurrentView('battle')}
      />
    );
  }

  return (
    <div className="mx-auto w-full space-y-6 animate-enter">
      {/* HEADER SECTION */}
      <div className="mb-6">
        <h2 className="section-title text-2xl md:text-3xl">
          ⚔️ GvG Роздоріжжя
        </h2>
        <p className="mt-2 text-sm text-foreground-secondary">
          Оберіть потрібний напрямок: перегляд поточної битви гільдії або керування кодами атаки.
        </p>
      </div>

      {/* CARDS GRID */}
      <div className="grid grid-cols-1 gap-6 md:grid-cols-3">
        {/* 1. Поточна битва GvG */}
        <button
          type="button"
          onClick={() => setCurrentView('battle')}
          className="card group flex flex-col justify-between border-amber-500/40 bg-gradient-to-br from-surface-raised via-amber-500/10 to-surface-raised p-6 text-left transition-all duration-200 hover:-translate-y-1 hover:border-amber-500 hover:shadow-[0_10px_20px_-3px_rgb(245,158,11/0.3)]"
        >
          <div>
            <div className="mb-4 inline-flex h-12 w-12 items-center justify-center rounded-xl border border-amber-500/40 bg-amber-500/20 text-2xl text-amber-400 transition-transform duration-200 group-hover:scale-110">
              🛡️
            </div>

            <h3 className="text-lg font-bold text-amber-400">
              Поточна битва GvG
            </h3>

            <p className="mt-2 text-sm text-foreground-secondary">
              Керування раундами, вежами, фортами та статусами пробиття гільдії.
            </p>
          </div>

          <div className="mt-6 flex items-center text-sm font-semibold text-amber-400">
            <span>Відкрити битву гільдії</span>
            <span className="ml-2 transition-transform duration-200 group-hover:translate-x-1.5">→</span>
          </div>
        </button>

        {/* 2. Знайти пресет */}
        <button
          type="button"
          onClick={() => setCurrentView('search')}
          className="card group flex flex-col justify-between border-brand-secondary/40 bg-gradient-to-br from-surface-raised via-brand-secondary/10 to-surface-raised p-6 text-left transition-all duration-200 hover:-translate-y-1 hover:border-brand-secondary hover:shadow-[0_10px_20px_-3px_rgb(88_28_135/0.4)]"
        >
          <div>
            <div className="mb-4 inline-flex h-12 w-12 items-center justify-center rounded-xl border border-brand-secondary/40 bg-brand-secondary/20 text-2xl text-brand-secondary-hover transition-transform duration-200 group-hover:scale-110">
              🔍
            </div>

            <h3 className="text-lg font-bold text-brand-secondary-hover">
              Знайти код атаки
            </h3>

            <p className="mt-2 text-sm text-foreground-secondary">
              Перегляд, фільтрація та пошук збереженого коду атаки на основі розстановки.
            </p>
          </div>

          <div className="mt-6 flex items-center text-sm font-semibold text-brand-secondary-hover">
            <span>Перейти до пошуку коду атаки</span>
            <span className="ml-2 transition-transform duration-200 group-hover:translate-x-1.5">→</span>
          </div>
        </button>

        {/* 3. Створити пресет */}
        <button
          type="button"
          onClick={() => setCurrentView('create')}
          className="card group flex flex-col justify-between border-brand-accent/40 bg-gradient-to-br from-surface-raised via-brand-accent/10 to-surface-raised p-6 text-left transition-all duration-200 hover:-translate-y-1 hover:border-brand-accent hover:shadow-[0_10px_20px_-3px_rgb(120_53_15/0.4)]"
        >
          <div>
            <div className="mb-4 inline-flex h-12 w-12 items-center justify-center rounded-xl border border-brand-accent/40 bg-brand-accent/20 text-2xl text-brand-accent-hover transition-transform duration-200 group-hover:scale-110">
              ➕
            </div>

            <h3 className="text-lg font-bold text-brand-accent-hover">
              Створити код атаки
            </h3>

            <p className="mt-2 text-sm text-foreground-secondary">
              Створити код атаки та додати в колекцію гільдії.
            </p>
          </div>

          <div className="mt-6 flex items-center text-sm font-semibold text-brand-accent-hover">
            <span>Створити код атаки</span>
            <span className="ml-2 transition-transform duration-200 group-hover:translate-x-1.5">→</span>
          </div>
        </button>
      </div>
    </div>
  );
}