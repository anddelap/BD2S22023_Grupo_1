import axios from 'axios';
import { variable } from './variables';
const baseUrl = variable.base_url;

console.log(baseUrl)
const api = axios.create({
    baseURL: baseUrl,
});

export const getDatetime = () => api.get('/datetime').then(res=>res.data);

//get sugerencias de amistad
export const sendLog = (data) => {
    return api.post('/friend/getNotFriends', data)
};

export const useSendLog = () =>{
    return useMutation(sendLog,{
        onSuccess: (data) => {
            console.log(data)
        }
    });
}