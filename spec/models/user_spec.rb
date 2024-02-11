require 'rails_helper'

RSpec.describe User, type: :model do

  context 'Associations' do

    it 'has_many group_messages' do 
      association = described_class.reflect_on_association(:group_messages)
      expect(association.macro).to eq :has_many
      expect(association.options[:class_name]).to eq 'Group::Message'
    end
    
    it 'has_and_belongs_to_many group_conversations' do
      association = described_class.reflect_on_association(:group_conversations)
      expect(association.macro).to eq :has_and_belongs_to_many
      expect(association.options[:class_name]).to eq 'Group::Conversation'
    end
    
    it 'has_many posts' do
      association = described_class.reflect_on_association(:posts)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end
    it 'has_many contacts' do
      association = described_class.reflect_on_association(:contacts)
      expect(association.macro).to eq :has_many
    end
  
    it 'has_many all_received_contact_requests' do
      association = described_class.reflect_on_association(:all_received_contact_requests)
      expect(association.macro).to eq :has_many
      expect(association.options[:class_name]).to eq 'Contact'
      expect(association.options[:foreign_key]).to eq 'contact_id'
    end
  
    it 'has_many accepted_sent_contact_requests' do
      association = described_class.reflect_on_association(:accepted_sent_contact_requests)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :contacts
      expect(association.options[:source]).to eq :contact
    end
  
    it 'has_many accepted_received_contact_requests' do
      association = described_class.reflect_on_association(:accepted_received_contact_requests)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :all_received_contact_requests
      expect(association.options[:source]).to eq :user
    end
  
    it 'has_many pending_sent_contact_requests' do
      association = described_class.reflect_on_association(:pending_sent_contact_requests)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :contacts
      expect(association.options[:source]).to eq :contact
    end
  
    it 'has_many pending_received_contact_requests' do
      association = described_class.reflect_on_association(:pending_received_contact_requests)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :all_received_contact_requests
      expect(association.options[:source]).to eq :user
    end
  end

  context 'Methods' do
    let(:user) { build(:user) }
    let(:contact_requests) do
      @user = create(:user)
      create_list(:contact, 2)
      create_list(:contact, 2, accepted: true)
      create(:contact, user_id: @user.id)
      create(:contact, user_id: @user.id, accepted: true)
      create(:contact, contact_id: @user.id)
      create(:contact, contact_id: @user.id, accepted: true)
    end
  
    it 'accepted_sent_contact_requests gets only accepted requests' do
      contact_requests
      expect(@user.accepted_sent_contact_requests.count).to eq 1
    end
  
    it 'accepted_received_contact_requests gets only accepted requests' do
      contact_requests
      expect(@user.accepted_received_contact_requests.count).to eq 1
    end
  
    it 'pending_sent_contact_requests gets only unaccepted requests' do
      contact_requests
      expect(@user.pending_sent_contact_requests.count).to eq 1
    end
  
    it 'pending_received_contact_requests gets only unaccepted requests' do
      contact_requests
      expect(@user.pending_received_contact_requests.count).to eq 1
    end
  end
end