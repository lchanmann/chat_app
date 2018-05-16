<template>
  <div class="message-composer">
    Messages: <br />
    <textarea id="message" rows="3" v-model="content"></textarea> <br />
    <button id="btnSend" @click="sendMessage">Send</button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      content: ''
    }
  },
  methods: {
    sendMessage() {
      this.$emit('send', this.content);
      this.content = '';
    }
  }
}
</script>
