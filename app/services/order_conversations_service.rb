class OrderConversationsService
  def initialize(params)
    @user = params[:user]
  end

  # get and order conversations by last messages' dates in descending order
  def call
    all_private_conversations = Private::Conversation.all_by_user(@user.id)
                                                    .includes(:messages)
    all_group_conversations = @user.group_conversations.includes(:messages)
    all_conversations = all_private_conversations + all_group_conversations

    # Sort conversations by last message's created_at if the conversation has messages
    all_conversations.sort_by! do |conversation|
      last_message = conversation.messages.last
      last_message&.created_at || conversation.created_at
    end.reverse
  end
end
