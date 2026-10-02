import React, { useState, useEffect } from 'react';
import api from '../api/axios';

/**
 * ==============================================================================
 * COMPONENT: GuildPage
 * ==============================================================================
 * Manages the guild interface acting as a conditional view switcher:
 * 1. If the user belongs to a guild -> Displays the guild header and member roster.
 * 2. If the user does not belong to a guild -> Displays the join-by-code form
 *    (and create guild option if the user has ADMIN privileges).
 */
export default function GuildPage({ user }) {

 // ==========================================
 // 1. COMPONENT STATE
 // ==========================================

 // Tab switcher for non-guild view ('join' or 'create')
  const [guildFormTab, setGuildFormTab] = useState('join');

  // Form input states
  const [inviteCode, setInviteCode] = useState('');
  const [guildName, setGuildName] = useState('');

  // Status, error handling, and loading indicators for form submissions
  const [error, setError] = useState('');
  const [successMsg, setSuccessMsg] = useState('');
  const [loading, setLoading] = useState(false);

  // Guild members list state and loading indicator
  const [members, setMembers] = useState([]);
  const [loadingMembers, setLoadingMembers] = useState(false);

  // ==========================================
  // 2. USER ROLE CHECKS
  // ==========================================
  const isAdmin = user?.role === 'ADMIN';
  const isManagementAllowed = ['LEADER', 'ADMIN'].includes(user?.role);

  // ==========================================
  // 3. AUTO-FETCH MEMBERS ROSTER EFFECT
  // ==========================================
  // Triggers whenever the user's guild name changes. If they are in a guild,
  // automatically fetch the members list.
  useEffect(() => {
    if (user?.guildName) {
      fetchGuildMembers();
    }
  }, [user?.guildName]);

// ==========================================
// 4. API REQUEST HANDLERS
// ==========================================

// Fetch the roster of members for the current guild
  const fetchGuildMembers = async () => {
    setLoadingMembers(true);
    try {
      const response = await api.get('/guilds/members');
      setMembers(response.data);
    } catch (err) {
      console.error('Failed to load guild members:', err);
    } finally {
      setLoadingMembers(false);
    }
  };

// Handle joining a guild using an invite code
  const handleJoinGuild = async (e) => {
    e.preventDefault();
    setError('');
    setSuccessMsg('');
    setLoading(true);

    try {
      await api.post(`/guilds/join?inviteCode=${encodeURIComponent(inviteCode)}`);
      setSuccessMsg('Successfully joined the guild!');
      window.location.reload();
    } catch (err) {
      setError(err.response?.data?.message || 'Failed to join. Please check your invite code.');
    } finally {
      setLoading(false);
    }
  };

// Handle creating a new guild (Admin exclusive)
  const handleCreateGuild = async (e) => {
    e.preventDefault();
    setError('');
    setSuccessMsg('');
    setLoading(true);

    try {
      await api.post('/guilds/create', { name: guildName });
      setSuccessMsg('Guild created successfully!');
      window.location.reload();
    } catch (err) {
      setError(err.response?.data?.message || 'Failed to create guild.');
    } finally {
      setLoading(false);
    }
  };
// Change a member's role (e.g., promote to Officer or demote to Member)
  const handleChangeRole = async (memberId, newRole) => {
    try {
      await api.patch(`/guilds/members/${memberId}/role`, { role: newRole });
      fetchGuildMembers();
    } catch (err) {
      alert(err.response?.data?.message || 'Failed to update member role.');
    }
  };
// Kick a member from the guild with confirmation prompt
  const handleKickMember = async (memberId, username) => {
    if (!window.confirm(`Are you sure you want to kick ${username} from the guild?`)) return;

    try {
      await api.delete(`/guilds/members/${memberId}`);
      fetchGuildMembers();
    } catch (err) {
      alert(err.response?.data?.message || 'Failed to kick member.');
    }
  };

  // ==========================================
  // 5. RENDER VIEW A: User IS in a Guild
  // ==========================================

  if (user?.guildName) {
    return (
      <div className="space-y-6 max-w-5xl mx-auto">
        {/* Guild Header */}
        <div className="bg-slate-900/60 border border-slate-800 rounded-xl p-6 shadow-lg flex flex-col md:flex-row items-start md:items-center justify-between gap-4">
          <div>
            <h2 className="text-2xl font-bold text-amber-400">{user.guildName}</h2>
            <p className="text-slate-400 text-sm mt-1">
              Invite Code: <code className="bg-slate-950 px-2.5 py-1 rounded text-amber-300 border border-slate-800 font-mono">{user.inviteCode || 'N/A'}</code>
            </p>
          </div>
          <div className="flex items-center gap-3">
            <span className="bg-purple-900/40 text-purple-300 border border-purple-500/40 px-3 py-1.5 rounded-lg text-sm font-semibold">
              Your Role: <span className="text-amber-300">{user.role}</span>
            </span>
          </div>
        </div>

        {/* Members Roster */}
        <div className="bg-slate-900/60 border border-slate-800 rounded-xl p-6 shadow-lg">
          <div className="flex items-center justify-between mb-4">
            <h3 className="font-bold text-lg text-purple-200">Guild Roster ({members.length})</h3>
            {loadingMembers && <span className="text-xs text-slate-400 animate-pulse">Updating...</span>}
          </div>

          <div className="overflow-x-auto">
            <table className="w-full text-left text-sm text-slate-300">
              <thead className="bg-slate-950/60 text-xs uppercase text-slate-400 border-b border-slate-800">
                <tr>
                  <th className="py-3 px-4">Username</th>
                  <th className="py-3 px-4">Role</th>
                  {isManagementAllowed && <th className="py-3 px-4 text-right">Actions</th>}
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-800/50">
                {members.map((member) => (
                  <tr key={member.id} className="hover:bg-slate-800/30 transition">
                    <td className="py-3 px-4 font-semibold text-slate-200 flex items-center gap-2">
                      <div className="w-7 h-7 rounded bg-purple-950 border border-purple-500/30 flex items-center justify-center text-xs text-purple-300">
                        {member.username?.charAt(0).toUpperCase()}
                      </div>
                      {member.username}
                      {member.id === user.id && <span className="text-[10px] bg-slate-800 text-slate-400 px-1.5 py-0.5 rounded border border-slate-700">(You)</span>}
                    </td>

                    <td className="py-3 px-4">
                      <span className={`px-2.5 py-1 rounded-md text-xs font-bold border ${
                        member.role === 'LEADER'
                          ? 'bg-amber-500/10 text-amber-300 border-amber-500/40'
                          : member.role === 'OFFICER'
                          ? 'bg-purple-500/10 text-purple-300 border-purple-500/40'
                          : 'bg-slate-800/80 text-slate-400 border-slate-700'
                      }`}>
                        {member.role}
                      </span>
                    </td>

                    {/* Management actions */}
                    {isManagementAllowed && (
                      <td className="py-3 px-4 text-right">
                        {member.id !== user.id && member.role !== 'LEADER' ? (
                          <div className="flex items-center justify-end gap-2">
                            {member.role === 'MEMBER' ? (
                              <button
                                onClick={() => handleChangeRole(member.id, 'OFFICER')}
                                className="px-2 py-1 bg-purple-600/20 hover:bg-purple-600/40 text-purple-300 border border-purple-500/30 rounded text-xs transition cursor-pointer"
                              >
                                + Officer
                              </button>
                            ) : (
                              <button
                                onClick={() => handleChangeRole(member.id, 'MEMBER')}
                                className="px-2 py-1 bg-slate-800 hover:bg-slate-700 text-slate-300 border border-slate-700 rounded text-xs transition cursor-pointer"
                              >
                                - Member
                              </button>
                            )}

                            <button
                              onClick={() => handleKickMember(member.id, member.username)}
                              className="px-2 py-1 bg-red-500/10 hover:bg-red-500/20 text-red-400 border border-red-500/30 rounded text-xs transition cursor-pointer"
                            >
                              Kick
                            </button>
                          </div>
                        ) : (
                          <span className="text-slate-600 text-xs italic">—</span>
                        )}
                      </td>
                    )}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    );
  }

  // ---------------- OPTION 2: User has no Guild ----------------
  return (
    <div className="max-w-md mx-auto bg-slate-900/80 border border-slate-800 rounded-2xl p-6 shadow-xl backdrop-blur-md mt-10">
      <h2 className="text-xl font-bold text-purple-200 mb-4 text-center">Guild Management</h2>

      {/* Show tabs ONLY for ADMIN role */}
      {isAdmin && (
        <div className="flex gap-4 border-b border-slate-800 pb-2 mb-4 justify-center">
          <button
            onClick={() => { setGuildFormTab('join'); setError(''); }}
            className={`text-xs font-bold uppercase tracking-wider pb-1 transition-colors cursor-pointer ${
              guildFormTab === 'join' ? 'text-amber-400 border-b-2 border-amber-400' : 'text-slate-400 hover:text-slate-200'
            }`}
          >
            Join by Code
          </button>
          <button
            onClick={() => { setGuildFormTab('create'); setError(''); }}
            className={`text-xs font-bold uppercase tracking-wider pb-1 transition-colors cursor-pointer ${
              guildFormTab === 'create' ? 'text-amber-400 border-b-2 border-amber-400' : 'text-slate-400 hover:text-slate-200'
            }`}
          >
            Create Guild (Admin)
          </button>
        </div>
      )}

      {error && <div className="mb-4 text-xs bg-red-500/10 border border-red-500/30 text-red-400 p-2.5 rounded-lg">{error}</div>}
      {successMsg && <div className="mb-4 text-xs bg-emerald-500/10 border border-emerald-500/30 text-emerald-400 p-2.5 rounded-lg">{successMsg}</div>}

      {guildFormTab === 'join' ? (
        <form onSubmit={handleJoinGuild} className="space-y-4">
          <div>
            <label className="block text-xs font-semibold text-slate-400 uppercase tracking-wider mb-2">
              Invite Code
            </label>
            <input
              type="text"
              required
              placeholder="e.g. WOR-123"
              value={inviteCode}
              onChange={(e) => setInviteCode(e.target.value)}
              className="w-full bg-slate-950 border border-slate-700 rounded-lg px-3.5 py-2.5 text-sm text-white focus:outline-none focus:border-purple-500 placeholder:text-slate-600"
            />
          </div>
          <button
            type="submit"
            disabled={loading}
            className="w-full bg-purple-600 hover:bg-purple-700 text-white font-bold py-2.5 rounded-lg text-sm transition cursor-pointer disabled:opacity-50 shadow-lg shadow-purple-950/50"
          >
            {loading ? 'Joining...' : 'Join Guild'}
          </button>
        </form>
      ) : (
        <form onSubmit={handleCreateGuild} className="space-y-4">
          <div>
            <label className="block text-xs font-semibold text-slate-400 uppercase tracking-wider mb-2">
              Guild Name
            </label>
            <input
              type="text"
              required
              placeholder="Enter new guild name"
              value={guildName}
              onChange={(e) => setGuildName(e.target.value)}
              className="w-full bg-slate-950 border border-slate-700 rounded-lg px-3.5 py-2.5 text-sm text-white focus:outline-none focus:border-purple-500 placeholder:text-slate-600"
            />
          </div>
          <button
            type="submit"
            disabled={loading}
            className="w-full bg-amber-500 hover:bg-amber-600 text-slate-950 font-bold py-2.5 rounded-lg text-sm transition cursor-pointer disabled:opacity-50 shadow-lg shadow-amber-950/50"
          >
            {loading ? 'Creating...' : 'Create Guild'}
          </button>
        </form>
      )}
    </div>
  );
}