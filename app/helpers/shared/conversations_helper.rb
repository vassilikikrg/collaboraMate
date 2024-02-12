module Shared::ConversationsHelper

    def private_conv_seen_status(conversation) 
      # if the latest message of a conversation is not created by a current_user
      # and it is unseen, return an unseen-conv value
      not_created_by_user = conversation.messages.last.user_id != current_user.id
      unseen = conversation.messages.last.seen == false
      not_created_by_user && unseen ? 'unseen-conv' : ''
    end

    def group_conv_seen_status(conversation, current_user)
      # If there are no messages in the conversation, return an empty string
      return '' if conversation.messages.empty?
    
      if current_user.nil?
        '' # Return an empty string if current_user is nil
      else
        last_message = conversation.messages.last
        if last_message
          not_created_by_user = last_message.user_id != current_user.id
          seen_by_user = last_message.seen_by.include?(current_user.id)
          not_created_by_user && !seen_by_user ? 'unseen-conv' : ''
        else
          '' # Return an empty string if last_message is nil
        end
      end
    end   
  end