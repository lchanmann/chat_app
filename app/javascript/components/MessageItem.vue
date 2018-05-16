<template>
  <li>
    <span class="sent-by">{{ message.sent_by }}</span>
    <span class="content">{{ message.content }}</span>
  </li>
</template>

<script>
export default {
  props: {
    message: {
      type: Object,
      required: true
    }
  }
}
</script>
