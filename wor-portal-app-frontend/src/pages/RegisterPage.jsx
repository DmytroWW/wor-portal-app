import { useState } from 'react'
import api from '../api/axios'
import { AuthCard, TextField, Button, Alert } from '../components/ui'

export default function RegisterPage({ onSuccess, onSwitchToLogin }) {
  const [username, setUsername] = useState('')
  const [password, setPassword] = useState('')
  const [confirmPassword, setConfirmPassword] = useState('')
  const [inviteCode, setInviteCode] = useState('')
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')

    if (password !== confirmPassword) {
      setError('Passwords do not match')
      return
    }

    setLoading(true)

    try {
      const response = await api.post('/auth/register', {
        username,
        password,
        inviteCode: inviteCode.trim() || null,
      })
      const data = response.data

      if (data.token) {
        localStorage.setItem('token', data.token)
      }

      onSuccess?.(data)
    } catch (err) {
      setError(
        err.response?.data?.message ||
          'Registration failed. Check your details or invite code.'
      )
    } finally {
      setLoading(false)
    }
  }

  return (
    <AuthCard
      title="WoR Portal"
      subtitle="Create a player account"
      footer={
        <>
          Already have an account?{' '}
          <button
            type="button"
            onClick={onSwitchToLogin}
            className="text-brand-accent hover:text-brand-accent-hover font-medium transition-colors cursor-pointer"
          >
            Sign In
          </button>
        </>
      }
    >
      <Alert variant="danger">{error}</Alert>

      <form onSubmit={handleSubmit} className="space-y-4">
        <TextField
          label="Username"
          type="text"
          required
          autoComplete="username"
          value={username}
          onChange={(e) => setUsername(e.target.value)}
          placeholder="Enter your username"
        />

        <div>
          <TextField
            label="Guild Invite Code"
            type="text"
            value={inviteCode}
            onChange={(e) => setInviteCode(e.target.value)}
            placeholder="Optional (e.g., GUILD-123)"
            className="uppercase tracking-wider"
          />
          <p className="text-[11px] text-foreground-muted mt-1">
            If provided, you will immediately join the corresponding guild roster.
          </p>
        </div>

        <TextField
          label="Password"
          type="password"
          required
          autoComplete="new-password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          placeholder="••••••••"
        />

        <TextField
          label="Confirm Password"
          type="password"
          required
          autoComplete="new-password"
          value={confirmPassword}
          onChange={(e) => setConfirmPassword(e.target.value)}
          placeholder="••••••••"
        />

        <Button type="submit" variant="primary" loading={loading} className="w-full mt-2">
          Sign Up
        </Button>
      </form>
    </AuthCard>
  )
}