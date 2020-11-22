import consumer from "./consumer"

consumer.subscriptions.create("UpdChannel", {
  connected() {
	  console.log("connected");
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
	   console.log("got some stuff");
	   $('#current').html("<div>" + data.message + "</div>");
  }
});
