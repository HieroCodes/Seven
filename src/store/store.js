import { defineStore } from 'pinia';
import api from '../api';

export const useChatStore = defineStore('chat', {
    state: () => ({
        conversations: [],
        selectedConversation: null,
        messages: [],
    }),
    actions: {
        async fetchConversations() {
            const response = await api.getConversations();
            this.conversations = response.data;
        },
        async fetchMessages(conversationId) {
            const response = await api.getMessages(conversationId);
            this.messages = response.data;
        },
        selectConversation(conversation) {
            this.selectedConversation = conversation;
            this.fetchMessages(conversation.id);
        },
        async addMessage(message) {
            const response = await api.sendMessage(message);
            this.messages.push(response.data);
        },
    },
});
