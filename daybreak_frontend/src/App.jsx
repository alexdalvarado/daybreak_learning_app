import { useState, useEffect } from 'react'

function App() {
  const [patients, setPatients] = useState([])

  useEffect(() => {
    fetch('http://localhost:3000/patients')
      .then(response => response.json())
      .then(data => setPatients(data))
  }, [])

  return (
    <div style={{ maxWidth: 800, margin: '40px auto', fontFamily: 'system-ui, sans-serif' }}>
      <h1 style={{ fontSize: 28, marginBottom: 4 }}>Daybreak Patients</h1>
      <p style={{ color: '#666', marginBottom: 20 }}>{patients.length} patients</p>

      <table style={{ width: '100%', borderCollapse: 'collapse' }}>
        <thead>
          <tr style={{ borderBottom: '2px solid #e5e7eb', textAlign: 'left' }}>
            <th style={{ padding: '10px 12px', color: '#6b7280', fontWeight: 600, fontSize: 13, textTransform: 'uppercase', letterSpacing: '0.05em' }}>Name</th>
            <th style={{ padding: '10px 12px', color: '#6b7280', fontWeight: 600, fontSize: 13, textTransform: 'uppercase', letterSpacing: '0.05em' }}>Priority</th>
            <th style={{ padding: '10px 12px', color: '#6b7280', fontWeight: 600, fontSize: 13, textTransform: 'uppercase', letterSpacing: '0.05em' }}>Status</th>
            <th style={{ padding: '10px 12px', color: '#6b7280', fontWeight: 600, fontSize: 13, textTransform: 'uppercase', letterSpacing: '0.05em' }}>Created</th>
            <th style={{ padding: '10px 12px', color: '#6b7280', fontWeight: 600, fontSize: 13, textTransform: 'uppercase', letterSpacing: '0.05em' }}>Last Seen</th>
          </tr>
        </thead>
        <tbody>
          {patients.map(patient => (
            <tr key={patient.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
              <td style={{ padding: '12px', fontWeight: 500 }}>{patient.name}</td>
              <td style={{ padding: '12px' }}>
                <span style={{
                  display: 'inline-block',
                  padding: '2px 10px',
                  borderRadius: 9999,
                  fontSize: 13,
                  fontWeight: 500,
                  backgroundColor: patient.priority === 'high' ? '#fef2f2' : patient.priority === 'low' ? '#f0f9ff' : '#f9fafb',
                  color: patient.priority === 'high' ? '#991b1b' : patient.priority === 'low' ? '#1e40af' : '#4b5563',
                }}>
                  {patient.priority}
                </span>
              </td>
              <td style={{ padding: '12px' }}>
                <span style={{
                  display: 'inline-block',
                  padding: '2px 10px',
                  borderRadius: 9999,
                  fontSize: 13,
                  fontWeight: 500,
                  backgroundColor: patient.status === 'active' ? '#dcfce7' : '#f3f4f6',
                  color: patient.status === 'active' ? '#166534' : '#4b5563',
                }}>
                  {patient.status}
                </span>
              </td>
              <td style={{ padding: '12px', color: '#6b7280', fontSize: 14 }}>
                {new Date(patient.created_at).toLocaleDateString()}
              </td>
              <td style={{ padding: '12px', color: '#6b7280', fontSize: 14 }}>
                {patient.last_seen ? new Date(patient.last_seen).toLocaleString() : '—'}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}

export default App