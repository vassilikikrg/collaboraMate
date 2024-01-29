module Private::ConversationsHelper
    # get the opposite user of the conversation
    def private_conv_recipient(conversation)
        conversation.opposed_user(current_user)
    end
    # if the conversation has unshown messages, show a button to get them
    def load_private_messages(conversation)
        if conversation.messages.count > 0 
        'private/conversations/conversation/messages_list/link_to_previous_messages'
        else
        'shared/empty_partial'
        end 
    end
end
