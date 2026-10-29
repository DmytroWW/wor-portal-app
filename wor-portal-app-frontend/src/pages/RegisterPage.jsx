import { useState } from 'react';
import api from '../api/axios';
import { AuthCard, TextField, Button, Alert } from '../components/ui';

export default function RegisterPage({ onSuccess, onSwitchToLogin }) {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [inviteCode, setInviteCode] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (event) => {
    event.preventDefault();
    setError('');

    const normalizedUsername = username.trim();
    const normalizedInviteCode = inviteCode.trim().toUpperCase();

    if (normalizedUsername.length < 3 || normalizedUsername.length > 50) {
      setError("Ім'я користувача має містити від 3 до 50 символів.");
      return;
    }
    if (password.length < 8) {
      setError('Пароль має містити щонайменше 8 символів.');
      return;
    }
    if (password !== confirmPassword) {
      setError('Паролі не збігаються.');
      return;
    }

    setLoading(true);
    try {
      const response = await api.post('/auth/register', {
        username: normalizedUsername,
        password,
        inviteCode: normalizedInviteCode || null,
      });

      if (response.data?.token) {
        localStorage.setItem('token', response.data.token);
      }
      onSuccess?.(response.data);
    } catch (requestError) {
      setError(
        requestError.response?.data?.message
          || requestError.response?.data?.detail
          || 'Не вдалося зареєструватися. Перевір дані та інвайт-код.',
      );
    } finally {
      setLoading(false);
    }
  };

  return (
    <AuthCard
      title="WoR Portal"
      subtitle="Створи акаунт гравця"
      footer={(
        <>
          Уже маєш акаунт?{' '}
          <button
            type="button"
            onClick={onSwitchToLogin}
            className="font-medium text-brand-accent transition-colors hover:text-brand-accent-hover"
          >
            Увійти
          </button>
        </>
      )}
    >
      <Alert variant="danger">{error}</Alert>

      <form onSubmit={handleSubmit} className="space-y-4">
        <TextField
          label="Ім'я користувача"
          type="text"
          required
          minLength={3}
          maxLength={50}
          autoComplete="username"
          value={username}
          onChange={(event) => setUsername(event.target.value)}
          placeholder="Наприклад, shadow_player"
        />

        <div>
          <TextField
            label="Інвайт-код гільдії (необов'язково)"
            type="text"
            autoCapitalize="characters"
            value={inviteCode}
            onChange={(event) => setInviteCode(event.target.value.toUpperCase())}
            placeholder="WOR-XXXXXXXX"
            className="uppercase tracking-wider"
          />
          <p className="mt-1 text-[11px] text-foreground-muted">
            Можеш залишити поле порожнім і створити власну гільдію або приєднатися пізніше.
            Якщо введеш код, він має бути дійсним.
          </p>
        </div>

        <TextField
          label="Пароль"
          type="password"
          required
          minLength={8}
          autoComplete="new-password"
          value={password}
          onChange={(event) => setPassword(event.target.value)}
          placeholder="Щонайменше 8 символів"
        />

        <TextField
          label="Підтвердження пароля"
          type="password"
          required
          autoComplete="new-password"
          value={confirmPassword}
          onChange={(event) => setConfirmPassword(event.target.value)}
          placeholder="Повтори пароль"
        />

        <Button type="submit" variant="primary" loading={loading} className="mt-2 w-full">
          Створити акаунт
        </Button>
      </form>
    </AuthCard>
  );
}
