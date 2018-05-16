App.subscribe = function(roomId, onReceived) {
  const channel = { channel: "ChatChannel", room_id: roomId };

  App.chat = App.cable.subscriptions.create(channel, {
    received: function(data) {
      onReceived(data);
    },

    send_message: function(data) {
      return this.perform('send_message', { message: data['message'] });
    }
  });
}
