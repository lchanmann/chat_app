<template>
  <div id="app">
    <MessageList />
    <hr />
    <NewMessage @send="sendMessage" />
  </div>
</template>

<script>
import MessageList from './components/MessageList'
import NewMessage from './components/NewMessage'

export default {
  components: {
    MessageList, NewMessage
  },
  props: {
    dialogueType: {
      type: String,
      default: location.pathname.split('/')[1]
    }
  },
  methods: {
    sendMessage(content) {
      App.chat.sendMessage(this.dialogueType, {
        message: { content }
      });
    },
  }
}
</script>
