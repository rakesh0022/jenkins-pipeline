import React, { useEffect, useState } from 'react';
import { DndProvider } from 'react-dnd';
import { HTML5Backend } from 'react-dnd-html5-backend';
import axios from 'axios'; // Import Axios for API requests
import WorkflowCanvas from './components/WorkflowCanvas';
import ServiceComponent from './components/ServiceComponent';

const App = () => {
  // State to track available services and dropped services
  const [services, setServices] = useState([]);
  const [droppedServices, setDroppedServices] = useState([]);
  const [gcpProject, setGcpProject] = useState('');
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  // Fetch services from the backend on component mount
  useEffect(() => {
    axios
      .get('http://34.85.156.204:5000/api/services') // Replace with your backend URL if different
      .then((response) => {
        setServices(response.data);
      })
      .catch((error) => {
        console.error('Error fetching services:', error);
      });
  }, []);

  // Handle dropping a service onto the canvas
  const handleDrop = (item) => {
    setDroppedServices((prev) => [...prev, item]);
  };
  
  const handleLogin = () => {
    // Dummy login functionality (replace with Google OAuth2)
    setIsAuthenticated(true);
  };
  
  const handleProjectSearch = (e) => {
    setGcpProject(e.target.value);
  };

  return (
    <DndProvider backend={HTML5Backend}>
      <div style={{ padding: '20px' }}>
        <h1>Workflow Builder</h1>
        <div style={{ display: 'flex', gap: '20px' }}>
          {/* Service Palette */}
          <div
            style={{
              width: '200px',
              padding: '10px',
              border: '1px solid #ddd',
              borderRadius: '10px',
            }}
          >
            <h3>Services</h3>
            {/* Dynamically render services fetched from the backend */}
            {services.map((service) => (
              <ServiceComponent key={service.id} id={service.id} name={service.name} />
            ))}
          </div>

          {/* Workflow Canvas */}
          <WorkflowCanvas onDrop={handleDrop} />
        </div>

        {/* Dropped Services */}
        <div style={{ marginTop: '20px' }}>
          <h3>Dropped Services:</h3>
          <ul>
            {droppedServices.map((service, index) => (
              <li key={index}>{service.name}</li>
            ))}
          </ul>
        </div>
      </div>
    </DndProvider>
  );
};

export default App;
