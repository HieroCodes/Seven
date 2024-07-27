<template>
  <div>
    <v-list>
      <v-list-item v-for="message in messages" :key="message.id">
        <v-list-item-content>
          <v-list-item-title>{{ message.text }}</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
    <v-text-field v-model="newMessage" label="Type a message" @keyup.enter="sendMessage"></v-text-field>
    <v-btn @click="sendMessage">Send</v-btn>
  </div>
</template>

<script>
import { useChatStore } from '../store';
import { mapActions, mapState } from 'pinia';

export default {
  data() {
    return {
      newMessage: '',
    };
  },
  computed: {
    ...mapState(useChatStore, ['selectedConversation', 'messages']),
  },
  methods: {
    ...mapActions(useChatStore, ['addMessage']),
    sendMessage() {
      if (this.newMessage.trim()) {
        const message = {
          id: Date.now(),
          text: this.newMessage.trim(),
          conversationId: this.selectedConversation.id,
        };
        this.addMessage(message);
        this.newMessage = '';
      }
    },
  },
};
</script>
