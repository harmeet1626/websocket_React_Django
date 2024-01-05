import Navbar from './components/navbar';
import { Router_view } from './routes/routes';
import './App.css'
function App() {
  return (
    <div className='application'>
      <Navbar />
      <Router_view />
    </div>
  );
}

export default App;
