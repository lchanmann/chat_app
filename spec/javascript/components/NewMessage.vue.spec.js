import { shallowMount } from '@vue/test-utils'
import NewMessage from '../../../app/javascript/components/NewMessage'

describe('NewMessage.vue', () => {
  it('renders message input', () => {
    const wrapper = shallowMount(NewMessage);
    expect(wrapper.find('textarea').exists()).toBe(true);
  });

  it('renders send button', () => {
    const wrapper = shallowMount(NewMessage);
    expect(wrapper.find('button').exists()).toBe(true);
  });

  describe('button click', () => {
    let wrapper;
    const spy = jasmine.createSpyObj('chat', ['sendMessage']);
    const dialogueType = 'test';
    const content = 'hello';

    beforeEach(() => {
      wrapper = shallowMount(NewMessage, {
        propsData: {
          dialogueType,
          app: { chat: spy }
        }
      });
      wrapper.setData({ content });
    });

    it('sends message to chat service', () => {
      wrapper.find('button').trigger('click');
      expect(spy.sendMessage).toHaveBeenCalledWith(
        dialogueType,
        { message: { content } }
      );
    });

    it('clear message content', () => {
      wrapper.find('button').trigger('click');
      expect(wrapper.vm.content).toEqual('');
    });
  });
})
