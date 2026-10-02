import { useState, useEffect } from 'react';
import api from './api/axios';
import LoginPage from './pages/LoginPage';
import RegisterPage from './pages/RegisterPage';
import DashboardPage from './pages/DashboardPage';

function App() {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [page, setPage] = useState('login');

  const fetchUserProfile = async () => {
    try {
      const res = await api.get('/users/me');
      setUser(res.data);
    } catch (err) {
      localStorage.removeItem('token');
      setUser(null);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    const token = localStorage.getItem('token');
    if (token) {
      fetchUserProfile();
    } else {
      setLoading(false);
    }
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
      <div className="flex justify-center items-center h-screen bg-slate-900 text-white font-semibold">
        Завантаження...
      </div>
    );
  }


  if (user) {
    return <DashboardPage user={user} onLogout={handleLogout} />;
  }

  return (
    <div className="min-h-screen bg-slate-900 flex justify-center items-center">
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