context 'Scopes' do
    it 'gets a conversation between users' do
      user1 = create(:user)
      user2 = create(:user)
      create(:private_conversation, recipient_id: user1.id, sender_id: user2.id)
      conversation = Private::Conversation.between_users(user1.id, user2.id)
      expect(conversation.count).to eq 1
    end
  end
  context 'Methods' do
    it 'gets an opposed user of the conversation' do
      user1 = create(:user)
      user2 = create(:user)
      conversation = create(:private_conversation,
                             recipient_id: user1.id,
                             sender_id: user2.id)
      opposed_user = conversation.opposed_user(user1)
      expect(opposed_user).to eq user2
    end
  end

  context 'Scopes' do
    it "gets all user's conversations" do
      create_list(:private_conversation, 5)
      user = create(:user)
      create_list(:private_conversation, 2, recipient_id: user.id)
      create_list(:private_conversation, 2, sender_id: user.id)
      conversations = Private::Conversation.all_by_user(user.id)
      expect(conversations.count).to eq 4
    end 
  end