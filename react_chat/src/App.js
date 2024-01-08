import Navbar from './components/navbar';
import { Router_view } from './routes/routes';
import './App.css'
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
function App() {
  return (
    <div className='application'>
      <ToastContainer />
      <Navbar />
      <Router_view />
    </div>
  );
}

export default App;
