class Group::MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message, previous_message, current_user)
    # broadcast message to all conversation's participants
    conversation_id = message.conversation_id
    ActionCable.server.broadcast(
      "group_conversation_#{conversation_id}",{
      message: render_message(message, previous_message),
      conversation_id: conversation_id,
      user_id: message.user_id
      }
    )
  end

  def render_message(message, previous_message)
    ApplicationController.render(
      partial: 'group/messages/message',
      locals: { message: message, 
                previous_message: previous_message, 
                user: message.user }
    )
  end

end
