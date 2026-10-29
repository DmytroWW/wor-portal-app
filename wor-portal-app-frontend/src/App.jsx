import { useState, useEffect } from 'react';
import api from './api/axios';
import LoginPage from './pages/LoginPage';
import RegisterPage from './pages/RegisterPage';
import DashboardPage from './pages/DashboardPage';

function App() {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [page, setPage] = useState('login');

  const refreshUserProfile = async () => {
    const response = await api.get('/users/me');
    setUser(response.data);
    return response.data;
  };

  const fetchUserProfile = async () => {
    try {
      await refreshUserProfile();
    } catch {
      localStorage.removeItem('token');
      setUser(null);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (localStorage.getItem('token')) {
      fetchUserProfile();
    } else {
      setLoading(false);
    }
    // Initial authentication check only.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handleAuthSuccess = () => {
    setLoading(true);
    fetchUserProfile();
  };

  const handleLogout = () => {
    localStorage.removeItem('token');
    setUser(null);
    setPage('login');
  };

  if (loading) {
    return (
      <div className="flex h-screen items-center justify-center bg-surface-base font-semibold text-foreground-primary">
        Завантаження...
      </div>
    );
  }

  if (user) {
    return (
      <DashboardPage
        user={user}
        onLogout={handleLogout}
        onRefreshUser={refreshUserProfile}
      />
    );
  }

  return (
    <div className="flex min-h-screen items-center justify-center bg-surface-base">
      {page === 'login' ? (
        <LoginPage
          onSuccess={handleAuthSuccess}
          onSwitchToRegister={() => setPage('register')}
        />
      ) : (
        <RegisterPage
          onSuccess={handleAuthSuccess}
          onSwitchToLogin={() => setPage('login')}
        />
      )}
    </div>
  );
}

export default App;
