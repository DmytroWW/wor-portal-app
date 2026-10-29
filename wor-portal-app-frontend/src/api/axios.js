import axios from 'axios';

// In development Vite proxies /api to localhost:8080. In production set
// VITE_API_BASE_URL if the API is hosted on a different base path/domain.
const api = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || '/api',
});

api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => Promise.reject(error),
);

export default api;
