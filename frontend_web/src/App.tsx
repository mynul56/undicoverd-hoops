import React, { useState } from 'react';
import { LayoutDashboard, Users, Video, Settings, ShieldCheck, Search } from 'lucide-react';

const MOCK_USERS = [
  { id: '1', name: 'Jalen Green', email: 'jalen@demo.com', role: 'PLAYER', verified: false, joined: '2026-06-01' },
  { id: '2', name: 'Coach Calipari', email: 'cal@demo.com', role: 'COACH', verified: true, joined: '2026-06-02' },
  { id: '3', name: 'AJ Dybantsa', email: 'aj@demo.com', role: 'PLAYER', verified: true, joined: '2026-06-03' },
  { id: '4', name: 'Scout Smith', email: 'scout@demo.com', role: 'COACH', verified: false, joined: '2026-06-04' },
];

function App() {
  const [activeTab, setActiveTab] = useState('users');
  const [users, setUsers] = useState(MOCK_USERS);

  const toggleVerification = (id: string) => {
    setUsers(users.map(u => u.id === id ? { ...u, verified: !u.verified } : u));
  };

  return (
    <div className="app-container">
      {/* Sidebar Navigation */}
      <aside className="sidebar">
        <div style={{ marginBottom: 40 }}>
          <h1 style={{ fontSize: 20, fontWeight: 900, letterSpacing: 2 }}>UNDISCOVERED</h1>
          <h1 style={{ fontSize: 20, fontWeight: 900, letterSpacing: 4, color: 'var(--neon-yellow)' }}>HOOPS</h1>
          <div style={{ fontSize: 10, color: 'var(--text-secondary)', marginTop: 4, letterSpacing: 1 }}>ADMIN DASHBOARD</div>
        </div>

        <nav style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
          <SidebarItem icon={<LayoutDashboard size={20} />} label="Overview" active={activeTab === 'overview'} onClick={() => setActiveTab('overview')} />
          <SidebarItem icon={<Users size={20} />} label="User Directory" active={activeTab === 'users'} onClick={() => setActiveTab('users')} />
          <SidebarItem icon={<Video size={20} />} label="Flagged Content" active={activeTab === 'content'} onClick={() => setActiveTab('content')} />
          <SidebarItem icon={<Settings size={20} />} label="Platform Settings" active={activeTab === 'settings'} onClick={() => setActiveTab('settings')} />
        </nav>
      </aside>

      {/* Main Content Area */}
      <main className="main-content">
        <header style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 40 }}>
          <div>
            <h2 style={{ fontSize: 28, fontWeight: 900 }}>User Directory</h2>
            <p style={{ color: 'var(--text-secondary)' }}>Manage athletes and verify recruiting accounts.</p>
          </div>
          
          <div className="glass-panel" style={{ display: 'flex', alignItems: 'center', padding: '8px 16px', gap: 12 }}>
            <Search size={18} color="var(--text-secondary)" />
            <input 
              type="text" 
              placeholder="Search by email..." 
              style={{ background: 'transparent', border: 'none', color: '#FFF', outline: 'none' }}
            />
          </div>
        </header>

        {/* Data Table */}
        <div className="glass-panel">
          <table>
            <thead>
              <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Account Type</th>
                <th>Status</th>
                <th>Joined</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {users.map(user => (
                <tr key={user.id}>
                  <td style={{ fontWeight: 600 }}>{user.name}</td>
                  <td style={{ color: 'var(--text-secondary)' }}>{user.email}</td>
                  <td>
                    <span className={`badge ${user.role.toLowerCase()}`}>{user.role}</span>
                  </td>
                  <td>
                    {user.verified ? (
                      <div style={{ display: 'flex', alignItems: 'center', gap: 6, color: 'var(--neon-yellow)' }}>
                        <ShieldCheck size={16} />
                        <span style={{ fontSize: 12, fontWeight: 600 }}>VERIFIED</span>
                      </div>
                    ) : (
                      <span style={{ fontSize: 12, color: 'var(--text-secondary)' }}>Pending</span>
                    )}
                  </td>
                  <td style={{ fontSize: 14, color: 'var(--text-secondary)' }}>{user.joined}</td>
                  <td>
                    <button 
                      className="btn-outline" 
                      onClick={() => toggleVerification(user.id)}
                      style={{ padding: '6px 12px', fontSize: 12, borderColor: user.verified ? 'var(--text-secondary)' : 'var(--neon-yellow)', color: user.verified ? 'var(--text-secondary)' : 'var(--neon-yellow)' }}
                    >
                      {user.verified ? 'Revoke' : 'Verify'}
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </main>
    </div>
  );
}

function SidebarItem({ icon, label, active, onClick }: { icon: React.ReactNode, label: string, active: boolean, onClick: () => void }) {
  return (
    <div 
      onClick={onClick}
      style={{
        display: 'flex',
        alignItems: 'center',
        gap: 16,
        padding: '12px 16px',
        borderRadius: 8,
        cursor: 'pointer',
        background: active ? 'rgba(228, 255, 0, 0.1)' : 'transparent',
        color: active ? 'var(--neon-yellow)' : 'var(--text-secondary)',
        fontWeight: active ? 600 : 400,
        transition: 'all 0.2s',
      }}
    >
      {icon}
      <span>{label}</span>
    </div>
  );
}

export default App;
