<template>
  <div class="message-composer">
    Messages: <br />
    <textarea id="message" rows="3" v-model="content"></textarea> <br />
    <button id="btnSend" v-on:click="sendMessage">Send</button>
  </div>
</template>

<script>
export default {
  props: {
    value: String
  },
  data() {
    return {
      content: this.value
    }
  },
  methods: {
    sendMessage() {
      // send message to action cable
      const dialogueType = location.pathname.split('/')[1];
      App.chat.sendMessage(dialogueType, {
        message: { content: this.content }
      });
      this.content = '';
    }
  }
}
</script>
