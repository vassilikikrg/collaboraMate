module Shared::ConversationsHelper

    def private_conv_seen_status(conversation) 
      # if the latest message of a conversation is not created by a current_user
      # and it is unseen, return an unseen-conv value
      not_created_by_user = conversation.messages.last.user_id != current_user.id
      unseen = conversation.messages.last.seen == false
      not_created_by_user && unseen ? 'unseen-conv' : ''
    end
  end