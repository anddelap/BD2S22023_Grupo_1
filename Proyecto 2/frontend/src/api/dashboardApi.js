import axios from 'axios';
import { variable } from './variables';
const baseUrl = variable.base_url;

console.log(baseUrl)
const api = axios.create({
    baseURL: baseUrl,
});

export const getAllDataMysql = () => api.get('/allDataMysql').then(res=>res.data);
export const getDepartamentosPresidentes= () => api.get('/DepartamentosPresidentes').then(res=>res.data);
export const getAllCircularMysql= () => api.get('/circularMysql').then(res=>res.data);
export const getTopSedes = () => api.get('/topSedes').then(res=>res.data);
export const getLastRedis = () => api.get('/lastRedis').then(res=>res.data);
