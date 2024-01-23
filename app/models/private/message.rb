class Private::Message < ApplicationRecord
    self.table_name = 'private_messages'

    # Associations
    belongs_to :user
    belongs_to :conversation, 
               class_name: 'Private::Conversation',
               foreign_key: :conversation_id
  end