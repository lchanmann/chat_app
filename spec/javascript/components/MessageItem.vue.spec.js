import { shallowMount } from '@vue/test-utils'
import MessageItem from '../../../app/javascript/components/MessageItem'

var wrapper;
const message = {
  'sent_by': 'me',
  'content': 'hello'
};

describe('MessageItem.vue', () => {
  beforeEach(() => {
    wrapper = shallowMount(MessageItem, {
      propsData: { message }
    });
  });

  it('renders message sender', () => {
    expect(wrapper.find('li > span.sent-by').text()).toEqual(message['sent_by']);
  });

  it('renders messgae content', () => {
    expect(wrapper.find('li > span.content').text()).toEqual(message['content']);
  });
})
