<template>
  <v-app>
    <v-main>
      <v-container>
        <ConversationsList />
        <ConversationView v-if="selectedConversation" />
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import { useChatStore } from './store/store';
import ConversationsList from './components/ConversationsList.vue';
import ConversationView from './components/ConversationView.vue';

export default {
  components: {
    ConversationsList,
    ConversationView,
  },
  computed: {
    selectedConversation() {
      const chatStore = useChatStore();
      return chatStore.selectedConversation;
    },
  },
  mounted() {
    const chatStore = useChatStore();
    chatStore.fetchConversations();
  },
};
</script>
