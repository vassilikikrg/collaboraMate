require 'rails_helper'
    RSpec.describe ConversationsHelper, :type => :helper do
        context '#load_private_messages' do
        let(:conversation) { create(:private_conversation) }
      
        it "returns load_messages partial's path" do
          create(:private_message, conversation_id: conversation.id)
          expect(helper.load_private_messages(conversation)).to eq (
            'private/conversations/conversation/messages_list/link_to_previous_messages'
          )
        end
      
        it "returns empty partial's path" do
          expect(helper.load_private_messages(conversation)).to eq (
            'shared/empty_partial'
          )
        end
      end 
    end
end