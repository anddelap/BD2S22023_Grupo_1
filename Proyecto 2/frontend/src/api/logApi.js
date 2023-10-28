import axios from 'axios';
import { useMutation, useQueryClient } from 'react-query';
import { variable } from './variables';
const baseUrl = variable.base_url;

console.log(baseUrl)
const api = axios.create({
    baseURL: baseUrl,
});

//get sugerencias de amistad
export const sendLog = (data) => {
    return api.post('/logs', data)
};

export const useSendLog = () =>{
    return useMutation(sendLog,{
        onSuccess: (data) => {
            console.log(data)
        }
    });
}