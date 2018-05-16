<template>
  <div id="app">
    <MessageList />
    <hr />
    <NewMessage v-model="newMessageText" />
  </div>
</template>

<script>
import MessageList from './components/MessageList.vue'
import NewMessage from './components/NewMessage.vue'

export default {
  components: {
    MessageList, NewMessage
  },
  data() {
    return {
      newMessageText: ''
    }
  }
}
</script>
