import consumer from "channels/consumer"

consumer.subscriptions.create("PrivateConversationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    
    // if a link to the conversation in the conversations menu list exists
    // move the link to the top of the conversations menu list
    var conversation_menu_link = $('#conversations-menu ul')
                                     .find('#menu-pc' + data['conversation_id']);
    if (conversation_menu_link.length) {
        conversation_menu_link.prependTo('#conversations-menu ul');
    }
    
    // set variables
    var conversation = findConv(data['conversation_id'], 'p');
    var conversation_rendered = ConvRendered(data['conversation_id'], 'p');
    var messages_visible = ConvMessagesVisiblity(conversation);

    if (data['recipient'] == true) {
        // mark conversation as unseen, after new message is received
        $('#menu-pc' + data['conversation_id']).addClass('unseen-conv');
        // if conversation window exists
        if (conversation_rendered) {
            if (!messages_visible) {
            // change style of conv window when there are unseen messages
            // add an additional class to the conversation's window or something
            }
            conversation.find('.messages-list').find('ul').append(data['message']);
        }
        calculateUnseenConversations();
    }
    else {
        conversation.find('ul').append(data['message']);
    }

    if (conversation.length) {
        // after a new message was appended, scroll to the bottom of the conversation window
        var messages_list = conversation.find('.messages-list');
        var height = messages_list[0].scrollHeight;
        messages_list.scrollTop(height);
    }
  },
  send_message(message) {
    return this.perform('send_message', {
        message: message
    });
  }
});

$(document).on('submit', '.send-private-message', function(e) {
  e.preventDefault();
  var values = $(this).serializeArray();
  App.private_conversation.send_message(values);
  $(this).trigger('reset');
});