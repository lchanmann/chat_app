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
import MessageItem from './MessageItem'
import App from '../cable'

export default {
  components: {
    MessageItem
  },
  props: {
    resourceUrl: String,
    app: {
      type: Object,
      default() {
        return App
      }
    }
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
      // include cookies in fetch request
      fetch(this.resourceUrl, { credentials: 'include' })
        .then((response) => response.json())
        .then((data) => { this.messages = data });
    },
    subscribeToChannel() {
      this.app.subscribe(this.resourceUrl, (data) => {
        this.messages.push(data)
      });
    }
  }
}
</script>
