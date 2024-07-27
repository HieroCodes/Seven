<template>
  <v-list>
    <v-list-item
        v-for="conversation in conversations"
        :key="conversation.id"
        @click="selectConversation(conversation)"
    >
      <v-list-item-content>
        <v-list-item-title>{{ conversation.title }}</v-list-item-title>
      </v-list-item-content>
    </v-list-item>
  </v-list>
</template>

<script>
import { useChatStore } from '../store';
import { mapActions, mapState } from 'pinia';

export default {
  computed: {
    ...mapState(useChatStore, ['conversations']),
  },
  methods: {
    ...mapActions(useChatStore, ['selectConversation']),
  },
};
</script>
