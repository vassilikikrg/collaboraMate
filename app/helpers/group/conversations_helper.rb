module Group::ConversationsHelper
    def add_people_to_group_conv_list(conversation)
      contacts = current_user.all_active_contacts
      users_in_conv = conversation.users
      add_people_to_conv_list = []
      contacts.each do |contact|
        # if the contact is already in the conversation, remove it from the list
        if !users_in_conv.include?(contact)
          add_people_to_conv_list << contact
        end
      end
      add_people_to_conv_list
    end
  end