import axios from 'axios';

const apiClient = axios.create({
    baseURL: 'http://localhost:3000',
    withCredentials: false,
    headers: {
        Accept: 'application/json',
        'Content-Type': 'application/json',
    },
});

export default {
    getConversations() {
        return apiClient.get('/conversations');
    },
    getMessages(conversationId) {
        return apiClient.get(`/messages?conversationId=${conversationId}`);
    },
    sendMessage(message) {
        return apiClient.post('/messages', message);
    },
};
