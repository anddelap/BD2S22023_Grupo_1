import axios from 'axios';
import { variable } from './variables';
const baseUrl = variable.base_url;

console.log(baseUrl)
const api = axios.create({
    baseURL: baseUrl,
});

export const getAllPaciente = () => api.get('/data/pacientes').then(res=>res.data);
export const getAllHabitacion = () => api.get('/data/habitaciones').then(res=>res.data);

export const getReporte = (base,reporte) => api.get('/'+base+'/reporte/'+reporte).then(res=>res.data);