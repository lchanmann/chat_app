import { shallowMount } from '@vue/test-utils'
import ChatVue from '../../app/javascript/chat_vue'
import MessageList from '../../app/javascript/components/MessageList'
import NewMessage from '../../app/javascript/components/NewMessage'

describe("chat_vue.vue", () => {
  it("renders message list", () => {
    const wrapper = shallowMount(ChatVue);
    expect(wrapper.find(MessageList).exists()).toBe(true)
  })

  it("renders new message", () => {
    const wrapper = shallowMount(ChatVue);
    expect(wrapper.find(NewMessage).exists()).toBe(true)
  })

  const baseUrl = '/test_chat/1'

  it('computes resourceUrl from baseUrl', () => {
    const wrapper = shallowMount(ChatVue);
    wrapper.setData({ baseUrl })
    expect(wrapper.vm.resourceUrl).toEqual(`${baseUrl}/messages`)
  })

  it('computes dialogueType from baseUrl', () => {
    const wrapper = shallowMount(ChatVue);
    wrapper.setData({ baseUrl })
    expect(wrapper.vm.dialogueType).toEqual('test_chat')
  })
})
