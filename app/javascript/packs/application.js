import Vue from 'vue/dist/vue.esm'
import ChatVue from '../chat_vue.vue'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#app',
    template: '<ChatVue />',
    components: { ChatVue }
  })
})
