<template>
  <div class="message-composer">
    Messages: <br />
    <textarea id="message" rows="3" v-model="content"></textarea> <br />
    <button id="btnSend" @click="sendMessage">Send</button>
  </div>
</template>

<script>
import App from '../cable'

export default {
  props: {
    dialogueType: String,
    app: {
      type: Object,
      default() {
        return App
      }
    }
  },
  data() {
    return {
      content: ''
    }
  },
  methods: {
    sendMessage() {
      this.app.chat.sendMessage(this.dialogueType, {
        message: {
          content: this.content
        }
      });
      this.content = '';
    }
  }
}
</script>
