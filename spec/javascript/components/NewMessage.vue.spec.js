import { shallowMount } from '@vue/test-utils'
import NewMessage from '../../../app/javascript/components/NewMessage'

var wrapper;
const content = 'hello';

describe('NewMessage.vue', () => {
  beforeEach(() => {
    wrapper = shallowMount(NewMessage);
  });

  it('renders message input', () => {
    expect(wrapper.find('textarea').exists()).toBe(true);
  });

  it('renders send button', () => {
    expect(wrapper.find('button').exists()).toBe(true);
  });

  describe('button click', () => {
    it('emits send event with message content', () => {
      wrapper.setData({ content });

      wrapper.find('button').trigger('click');
      expect(wrapper.emitted('send')[0]).toEqual([content]);
    });

    it('clear message content', () => {
      wrapper.setData({ content });

      wrapper.find('button').trigger('click');
      expect(wrapper.vm.content).toEqual('');
    });
  });
})
