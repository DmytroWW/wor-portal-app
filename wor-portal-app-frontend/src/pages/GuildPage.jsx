import { useCallback, useEffect, useState } from 'react';
import api from '../api/axios';

const roleLabel = (role) => ({
  LEADER: 'Лідер',
  OFFICER: 'Офіцер',
  MEMBER: 'Учасник',
}[role] || 'Учасник');

const getErrorMessage = (error, fallback) =>
  error?.response?.data?.message
  || error?.response?.data?.detail
  || error?.response?.data?.error
  || fallback;

const inputClass = 'mt-2 w-full rounded-lg border border-surface-border bg-surface-sunken px-3 py-2.5 text-sm text-foreground-primary outline-none placeholder:text-foreground-muted focus:border-brand-accent';
const primaryButtonClass = 'inline-flex items-center justify-center rounded-lg bg-brand-accent px-4 py-2.5 text-sm font-bold text-foreground-onAccent transition hover:bg-brand-accent-hover disabled:cursor-not-allowed disabled:opacity-50';
const secondaryButtonClass = 'inline-flex items-center justify-center rounded-lg border border-surface-border bg-surface-sunken px-3 py-2 text-sm font-semibold text-foreground-secondary transition hover:border-brand-accent/50 hover:text-foreground-primary disabled:cursor-not-allowed disabled:opacity-50';

export default function GuildPage({ user, onRefreshUser }) {
  const [formTab, setFormTab] = useState('join');
  const [inviteCode, setInviteCode] = useState('');
  const [guildName, setGuildName] = useState('');
  const [error, setError] = useState('');
  const [successMessage, setSuccessMessage] = useState('');
  const [loading, setLoading] = useState(false);
  const [members, setMembers] = useState([]);
  const [loadingMembers, setLoadingMembers] = useState(false);
  const [copied, setCopied] = useState(false);

  const hasGuild = Boolean(user?.guildId || user?.guildName);
  const isGuildLeader = user?.guildRole === 'LEADER';

  const fetchGuildMembers = useCallback(async () => {
    if (!user?.guildId && !user?.guildName) {
      setMembers([]);
      return;
    }

    setLoadingMembers(true);
    try {
      const response = await api.get('/guilds/members');
      setMembers(Array.isArray(response.data) ? response.data : []);
    } catch (requestError) {
      setError(getErrorMessage(requestError, 'Не вдалося завантажити список учасників.'));
    } finally {
      setLoadingMembers(false);
    }
  }, [user?.guildId, user?.guildName]);

  useEffect(() => {
    fetchGuildMembers();
  }, [fetchGuildMembers]);

  const refreshProfile = async () => {
    if (onRefreshUser) {
      await onRefreshUser();
    } else {
      window.location.reload();
    }
  };

  const handleJoinGuild = async (event) => {
    event.preventDefault();
    setError('');
    setSuccessMessage('');

    const code = inviteCode.trim().toUpperCase();
    if (!code) {
      setError('Введи інвайт-код гільдії.');
      return;
    }

    setLoading(true);
    try {
      const response = await api.post(`/guilds/join?inviteCode=${encodeURIComponent(code)}`);
      await refreshProfile();
      setInviteCode('');
      setSuccessMessage(`Ти приєднався до гільдії «${response.data?.name || 'гільдія'}».`);
    } catch (requestError) {
      setError(getErrorMessage(requestError, 'Не вдалося приєднатися. Перевір інвайт-код.'));
    } finally {
      setLoading(false);
    }
  };

  const handleCreateGuild = async (event) => {
    event.preventDefault();
    setError('');
    setSuccessMessage('');

    const name = guildName.trim();
    if (!name || name.length > 100) {
      setError('Назва гільдії має містити від 1 до 100 символів.');
      return;
    }

    setLoading(true);
    try {
      const response = await api.post('/guilds/create', { name });
      await refreshProfile();
      setGuildName('');
      setSuccessMessage(`Гільдію «${response.data?.name || name}» створено. Ти став її лідером.`);
    } catch (requestError) {
      setError(getErrorMessage(requestError, 'Не вдалося створити гільдію.'));
    } finally {
      setLoading(false);
    }
  };

  const handleCopyInviteCode = async () => {
    if (!user?.inviteCode) return;
    setError('');
    try {
      await navigator.clipboard.writeText(user.inviteCode);
      setCopied(true);
      window.setTimeout(() => setCopied(false), 1800);
    } catch {
      setError('Не вдалося автоматично скопіювати код. Виділи його та скопіюй вручну.');
    }
  };

  const handleRotateInviteCode = async () => {
    if (!window.confirm('Створити новий інвайт-код? Старий код перестане працювати.')) return;
    setError('');
    setSuccessMessage('');
    setLoading(true);
    try {
      const response = await api.put('/guilds/invite-code');
      await refreshProfile();
      setSuccessMessage(`Новий код гільдії: ${response.data?.inviteCode || 'оновлено'}`);
    } catch (requestError) {
      setError(getErrorMessage(requestError, 'Не вдалося оновити інвайт-код.'));
    } finally {
      setLoading(false);
    }
  };

  const handleChangeRole = async (memberId, role) => {
    setError('');
    setSuccessMessage('');
    try {
      await api.patch(`/guilds/members/${memberId}/role`, { role });
      await fetchGuildMembers();
      setSuccessMessage('Ранг учасника оновлено.');
    } catch (requestError) {
      setError(getErrorMessage(requestError, 'Не вдалося змінити ранг учасника.'));
    }
  };

  const handleKickMember = async (member) => {
    if (!window.confirm(`Виключити ${member.username} з гільдії?`)) return;
    setError('');
    setSuccessMessage('');
    try {
      await api.delete(`/guilds/members/${member.id}`);
      await fetchGuildMembers();
      setSuccessMessage(`Учасника ${member.username} виключено з гільдії.`);
    } catch (requestError) {
      setError(getErrorMessage(requestError, 'Не вдалося виключити учасника.'));
    }
  };

  const handleTransferLeadership = async (member) => {
    if (!window.confirm(`Передати лідерство користувачу ${member.username}? Ти станеш офіцером.`)) return;
    setError('');
    setSuccessMessage('');
    setLoading(true);
    try {
      await api.patch(`/guilds/members/${member.id}/leader`);
      await refreshProfile();
      await fetchGuildMembers();
      setSuccessMessage(`Лідерство передано користувачу ${member.username}.`);
    } catch (requestError) {
      setError(getErrorMessage(requestError, 'Не вдалося передати лідерство.'));
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="mx-auto mt-2 max-w-5xl space-y-5">
      <header>
        <p className="text-xs font-bold uppercase tracking-widest text-brand-accent">Гільдія / Менеджмент</p>
        <h1 className="mt-1 text-2xl font-extrabold text-foreground-primary">Керування гільдією</h1>
        <p className="mt-1 text-sm text-foreground-muted">Створюй власну гільдію або приєднуйся до друзів за інвайт-кодом.</p>
      </header>

      {error && <div role="alert" className="rounded-xl border border-brand-danger/40 bg-brand-danger/10 p-3 text-sm text-red-300">{error}</div>}
      {successMessage && <div role="status" className="rounded-xl border border-brand-success/40 bg-brand-success/10 p-3 text-sm text-emerald-300">{successMessage}</div>}

      {!hasGuild ? (
        <section className="mx-auto max-w-2xl rounded-2xl border border-surface-border bg-surface-raised p-4 shadow-surface sm:p-6">
          <div className="mb-5 text-center">
            <div className="mx-auto flex h-14 w-14 items-center justify-center rounded-2xl border border-brand-accent/30 bg-brand-accent/10 text-3xl">🏰</div>
            <h2 className="mt-3 text-xl font-bold">Обери свою гільдію</h2>
            <p className="mt-1 text-sm text-foreground-muted">Гільдія потрібна для спільних GvG-пресетів та координації битв, але створювати її під час реєстрації необов'язково.</p>
          </div>

          <div className="mb-5 grid grid-cols-2 gap-2 rounded-xl border border-surface-border bg-surface-overlay p-1">
            <button
              type="button"
              onClick={() => { setFormTab('join'); setError(''); setSuccessMessage(''); }}
              className={`rounded-lg px-3 py-2.5 text-sm font-bold transition ${formTab === 'join' ? 'bg-brand-accent text-foreground-onAccent' : 'text-foreground-secondary hover:bg-surface-sunken'}`}
            >
              Приєднатися
            </button>
            <button
              type="button"
              onClick={() => { setFormTab('create'); setError(''); setSuccessMessage(''); }}
              className={`rounded-lg px-3 py-2.5 text-sm font-bold transition ${formTab === 'create' ? 'bg-brand-accent text-foreground-onAccent' : 'text-foreground-secondary hover:bg-surface-sunken'}`}
            >
              Створити гільдію
            </button>
          </div>

          {formTab === 'join' ? (
            <form onSubmit={handleJoinGuild} className="space-y-4">
              <label className="block text-sm font-semibold text-foreground-secondary">
                Інвайт-код
                <input
                  type="text"
                  value={inviteCode}
                  onChange={(event) => setInviteCode(event.target.value.toUpperCase())}
                  placeholder="WOR-XXXXXXXX"
                  autoComplete="off"
                  className={`${inputClass} uppercase tracking-wider`}
                  required
                />
              </label>
              <button type="submit" disabled={loading} className={`${primaryButtonClass} w-full`}>
                {loading ? 'Приєднання…' : 'Приєднатися до гільдії'}
              </button>
            </form>
          ) : (
            <form onSubmit={handleCreateGuild} className="space-y-4">
              <label className="block text-sm font-semibold text-foreground-secondary">
                Назва гільдії
                <input
                  type="text"
                  value={guildName}
                  onChange={(event) => setGuildName(event.target.value)}
                  placeholder="Наприклад, NoNameClan"
                  maxLength={100}
                  className={inputClass}
                  required
                />
              </label>
              <p className="text-xs text-foreground-muted">Ти автоматично станеш лідером нової гільдії та отримаєш інвайт-код.</p>
              <button type="submit" disabled={loading} className={`${primaryButtonClass} w-full`}>
                {loading ? 'Створення…' : 'Створити гільдію'}
              </button>
            </form>
          )}
        </section>
      ) : (
        <>
          <section className="rounded-2xl border border-surface-border bg-surface-raised p-4 shadow-surface sm:p-6">
            <div className="flex flex-col justify-between gap-4 md:flex-row md:items-center">
              <div className="min-w-0">
                <p className="text-xs font-bold uppercase tracking-widest text-brand-accent">Твоя гільдія</p>
                <h2 className="mt-1 break-words text-2xl font-extrabold text-foreground-primary">{user?.guildName || 'Гільдія'}</h2>
                <p className="mt-1 text-sm text-foreground-muted">Твій ранг: <span className="font-bold text-brand-accent-hover">{roleLabel(user?.guildRole)}</span></p>
              </div>
              <div className="flex flex-wrap gap-2">
                {user?.inviteCode && (
                  <button type="button" onClick={handleCopyInviteCode} className={secondaryButtonClass}>
                    {copied ? '✓ Скопійовано' : 'Копіювати інвайт'}
                  </button>
                )}
                {isGuildLeader && (
                  <button type="button" onClick={handleRotateInviteCode} disabled={loading} className={secondaryButtonClass}>
                    Оновити код
                  </button>
                )}
              </div>
            </div>

            <div className="mt-4 flex flex-col gap-3 rounded-xl border border-surface-border bg-surface-overlay p-3 sm:flex-row sm:items-center sm:justify-between">
              <div>
                <p className="text-xs font-semibold text-foreground-muted">ІНВАЙТ-КОД</p>
                <code className="mt-1 block break-all font-mono text-lg font-bold tracking-wider text-brand-accent-hover">{user?.inviteCode || 'Код недоступний'}</code>
              </div>
              <div className="rounded-lg border border-surface-border bg-surface-sunken px-3 py-2 text-sm">
                <span className="text-foreground-muted">Учасників: </span>
                <span className="font-bold text-foreground-primary">{members.length}</span>
              </div>
            </div>
            {isGuildLeader && <p className="mt-3 text-xs text-foreground-muted">Якщо оновиш код, старий код перестане працювати для нових учасників.</p>}
          </section>

          <section className="overflow-hidden rounded-2xl border border-surface-border bg-surface-raised shadow-surface">
            <div className="flex flex-wrap items-center justify-between gap-2 border-b border-surface-border p-4 sm:px-5">
              <div>
                <h3 className="text-lg font-bold">Учасники гільдії</h3>
                <p className="mt-1 text-xs text-foreground-muted">Керування рангами доступне тільки лідеру гільдії.</p>
              </div>
              {loadingMembers && <span className="text-xs text-foreground-muted">Оновлення…</span>}
            </div>

            {members.length === 0 && !loadingMembers ? (
              <div className="p-8 text-center text-sm text-foreground-muted">Список учасників порожній або ще завантажується.</div>
            ) : (
              <div className="overflow-x-auto">
                <table className="w-full min-w-[620px] text-left text-sm">
                  <thead className="bg-surface-overlay text-xs uppercase tracking-wide text-foreground-muted">
                    <tr>
                      <th className="px-4 py-3">Гравець</th>
                      <th className="px-4 py-3">Ранг</th>
                      <th className="px-4 py-3 text-right">Дії</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-surface-border">
                    {members.map((member) => {
                      const isSelf = String(member.id) === String(user?.id);
                      const isLeader = member.role === 'LEADER';
                      return (
                        <tr key={member.id} className="transition hover:bg-surface-sunken/40">
                          <td className="px-4 py-3">
                            <div className="flex items-center gap-3">
                              <div className="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg border border-brand-secondary/30 bg-brand-secondary/10 font-bold text-brand-secondary-hover">
                                {member.username?.charAt(0)?.toUpperCase() || '?'}
                              </div>
                              <div className="min-w-0">
                                <p className="break-all font-semibold text-foreground-primary">{member.username}</p>
                                {isSelf && <p className="text-xs text-foreground-muted">Це ти</p>}
                              </div>
                            </div>
                          </td>
                          <td className="px-4 py-3">
                            <span className={`inline-flex rounded-md border px-2.5 py-1 text-xs font-bold ${
                              member.role === 'LEADER'
                                ? 'border-brand-accent/40 bg-brand-accent/10 text-brand-accent-hover'
                                : member.role === 'OFFICER'
                                  ? 'border-brand-secondary/40 bg-brand-secondary/10 text-brand-secondary-hover'
                                  : 'border-surface-border bg-surface-sunken text-foreground-secondary'
                            }`}>
                              {roleLabel(member.role)}
                            </span>
                            {member.platformRole === 'ADMIN' && <span className="ml-2 text-[10px] font-bold text-red-300">ADMIN ПОРТАЛУ</span>}
                          </td>
                          <td className="px-4 py-3 text-right">
                            {isGuildLeader && !isSelf && !isLeader ? (
                              <div className="flex flex-wrap justify-end gap-2">
                                {member.role === 'MEMBER' ? (
                                  <button type="button" onClick={() => handleChangeRole(member.id, 'OFFICER')} className={secondaryButtonClass}>Зробити офіцером</button>
                                ) : (
                                  <button type="button" onClick={() => handleChangeRole(member.id, 'MEMBER')} className={secondaryButtonClass}>Зняти ранг</button>
                                )}
                                <button type="button" onClick={() => handleTransferLeadership(member)} disabled={loading} className={secondaryButtonClass}>Передати лідерство</button>
                                <button type="button" onClick={() => handleKickMember(member)} className="rounded-lg border border-brand-danger/40 bg-brand-danger/10 px-3 py-2 text-xs font-bold text-red-300 transition hover:bg-brand-danger/20">Виключити</button>
                              </div>
                            ) : (
                              <span className="text-foreground-muted">—</span>
                            )}
                          </td>
                        </tr>
                      );
                    })}
                  </tbody>
                </table>
              </div>
            )}
          </section>
        </>
      )}
    </div>
  );
}
