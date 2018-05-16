App.subscribe = function(room, onReceived) {
  const channel = { channel: "ChatChannel", room: room };

  App.chat = App.cable.subscriptions.create(channel, {
    received: function(data) {
      onReceived(data);
    },

    send_message: function(dialogueType, data) {
      const action = (dialogueType == 'Chatroom' ? 'send_message' : 'send_private_message');
      return this.perform(action, { message: data['message'] });
    }
  });
}
