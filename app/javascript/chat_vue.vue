<template>
  <div id="app">
    <MessageList :resource-url="resourceUrl" />
    <hr />
    <NewMessage :dialogue-type="dialogueType"/>
  </div>
</template>

<script>
import MessageList from './components/MessageList'
import NewMessage from './components/NewMessage'

export default {
  components: {
    MessageList, NewMessage
  },
  data() {
    return {
      baseUrl: location.pathname
    }
  },
  computed: {
    resourceUrl() {
      return `${this.baseUrl}/messages`;
    },
    dialogueType() {
      return this.baseUrl.split('/')[1];
    }
  }
}
</script>
