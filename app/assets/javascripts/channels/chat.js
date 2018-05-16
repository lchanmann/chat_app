App.subscribe = function(room, onReceived) {
  const channel = { channel: "ChatChannel", room: room };

  App.chat = App.cable.subscriptions.create(channel, {
    received: function(data) {
      onReceived(data);
    },

    send_message: function(data) {
      return this.perform('send_message', { message: data['message'] });
    },

    send_private_message: function(data) {
      return this.perform('send_private_message', { message: data['message'] });
    }
  });
}
