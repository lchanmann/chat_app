<template>
  <div class="message-list">
    <ul v-if="messages.length">
      <MessageItem
        v-for="message in messages"
        :key="message.id"
        :message="message"
      />
    </ul>
    <p v-else>
      No messages
    </p>
  </div>
</template>

<script>
import MessageItem from './MessageItem.vue'

export default {
  components: {
    MessageItem
  },
  data() {
    return {
      messages: []
    }
  },
  created() {
    this.getAllMessages();
    this.subscribeToChannel();
  },
  methods: {
    getAllMessages() {
      var self = this;
      // include cookies in fetch request
      fetch(`${location.pathname}/messages`, { credentials: 'include' })
        .then((response) => response.json())
        .then((data) => { self.messages = data });
    },
    subscribeToChannel() {
      App.subscribe(location.pathname, (data) => {
        this.messages.push(data)
      });
    }
  }
}
</script>
