App.subscribe = function(room, onReceived) {
  const channel = { channel: "ChatChannel", room: room };

  App.chat = App.cable.subscriptions.create(channel, {
    received: function(data) {
      onReceived(data);
    },

    sendMessage: function(dialogueType, data) {
      const action = (dialogueType == 'chatrooms' ? 'send_message' : 'send_private_message');
      return this.perform(action, { message: data['message'] });
    }
  });
}
