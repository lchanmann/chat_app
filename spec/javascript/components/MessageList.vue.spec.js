import Vue from 'vue'
import { shallowMount } from '@vue/test-utils'
import MessageList from '../../../app/javascript/components/MessageList'
import MessageItem from '../../../app/javascript/components/MessageItem'

const messages = [
  { id: 1, sent_by: 'A', content: 'hello' },
  { id: 2, sent_by: 'B', content: 'hey' }
];
var spyMethods;

describe('MessageList.vue', () => {
  beforeEach(() => {
    spyMethods = {
      getAllMessages: jasmine.createSpy('getAllMessages'),
      subscribeToChannel: jasmine.createSpy('subscribeToChannel')
    };
  });

  it('renders text when no messages', () => {
    const wrapper = shallowMount(MessageList, {
      methods: spyMethods
    });
    expect(wrapper.text()).toEqual('No messages');
  });

  it('renders message items', () => {
    const wrapper = shallowMount(MessageList, {
      methods: spyMethods
    });
    // FIXME: change to `wrapper.setData({ messages })` when
    //        https://github.com/vuejs/vue-test-utils/pull/604 is released.
    wrapper.vm.$set(wrapper.vm, ['messages'], messages);
    expect(wrapper.findAll(MessageItem).length).toEqual(2);
  });

  describe('getAllMessages', () => {
    beforeEach(() => {
      delete spyMethods.getAllMessages;
      const response_promise = new Promise((resolve) => {
        resolve({
          json: () => messages
        })
      });
      spyOn(window, 'fetch').and.returnValue(response_promise);
    });

    it('fetches data from messages API', () => {
      const resourceUrl = '/url'
      const wrapper = shallowMount(MessageList, {
        propsData: { resourceUrl },
        methods: spyMethods
      });
      expect(window.fetch).toHaveBeenCalledWith(
        resourceUrl,
        { credentials: 'include' }
      );
    });

    it('updates messages data', () => {
      const wrapper = shallowMount(MessageList, {
        methods: spyMethods
      });
      // NOTE: promise-based call can only be tested via `nextTick`
      return new Vue.nextTick().then(() => {
        expect(wrapper.vm.messages).toEqual(messages);
      });
    });
  });
  
  describe('subscribeToChannel', () => {
    let spyApp;

    const resourceUrl = '/url';
    const message = { content: 'hello' };

    beforeEach(() => {
      delete spyMethods.subscribeToChannel;
      spyApp = {
        subscribe: jasmine.createSpy('subscribe').and.callFake((url, callback) => {
          callback(message)
        })
      };
    });

    it('calls action cable subscribe', () => {
      const wrapper = shallowMount(MessageList, {
        propsData: {
          resourceUrl,
          app: spyApp
        },
        methods: spyMethods
      });
      expect(spyApp.subscribe).toHaveBeenCalledWith(resourceUrl, jasmine.any(Function));
    });

    it('adds received data to messgaes', () => {
      const wrapper = shallowMount(MessageList, {
        propsData: {
          resourceUrl,
          app: spyApp
        },
        methods: spyMethods
      });
      expect(wrapper.vm.messages).toEqual([message]);
    });
  });
});
