import { useState } from 'react'
import api from '../../src/api/axios'
import { AuthCard, TextField, Button, Alert } from '../components/ui'


export default function LoginPage({ onSuccess, onSwitchToRegister }) {
  const [username, setUsername] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    setLoading(true)

    try {
      const response = await api.post('/auth/login', { username, password })
      const data = response.data

      if (data.token) {
        localStorage.setItem('token', data.token)
      }

      onSuccess?.(data)
    } catch (err) {
      setError(err.response?.data?.message || 'Invalid username or password')
    } finally {
      setLoading(false)
    }
  }

  return (
    <AuthCard
      title="WoR Portal"
      subtitle="Sign in to your account"
      footer={
        <>
          Don&apos;t have an account?{' '}
          <button
            type="button"
            onClick={onSwitchToRegister}
            className="text-brand-accent hover:text-brand-accent-hover font-medium transition-colors cursor-pointer"
          >
            Sign Up
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

        <TextField
          label="Password"
          type="password"
          required
          autoComplete="current-password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          placeholder="••••••••"
        />

        <Button type="submit" variant="primary" loading={loading} className="mt-2">
          Sign In
        </Button>
      </form>
    </AuthCard>
  )
}
