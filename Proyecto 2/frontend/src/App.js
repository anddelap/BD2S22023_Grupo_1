import './App.css';
import {
  BrowserRouter as Router,
  Route,
  Routes,
} from "react-router-dom";
import React from 'react';
import { rutas } from './utilities/routes';
import 'bootstrap/dist/css/bootstrap.min.css';

function App() {
  return (
    <Router>
        <Routes>
          {rutas.map((ruta,index)=>
            <Route path={ruta.path} element={<ruta.element/>}/>
          )}
        </Routes>
    </Router>
  );
}

export default App;
