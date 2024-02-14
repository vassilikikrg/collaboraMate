class Private::Message < ApplicationRecord
    self.table_name = 'private_messages'

    # Associations
    belongs_to :user
    belongs_to :conversation, 
               class_name: 'Private::Conversation',
               foreign_key: :conversation_id

    after_create_commit do 
    Private::MessageBroadcastJob.perform_later(self, previous_message)
    end

    def previous_message
    previous_message_index = self.conversation.messages.index(self) - 1
    self.conversation.messages[previous_message_index]
    end
  end