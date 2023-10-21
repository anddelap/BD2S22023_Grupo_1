import axios from 'axios';
import { variable } from './variables';
const baseUrl = variable.base_url;

console.log(baseUrl)
const api = axios.create({
    baseURL: baseUrl,
});

export const getDatetime = () => api.get('/datetime').then(res=>res.data);