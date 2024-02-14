class Private::MessagesController < ActionController::Base
    include Messages
    layout 'application'
    def index
      get_messages('private', 10)
      @user = current_user
      @is_messenger = params[:is_messenger]
      respond_to do |format|
        format.js { render partial: 'private/messages/load_more_messages' }
      end
    end

    def show
      @conversation = Private::Conversation.find(params[:conversation_id])
      @messages = @conversation.messages.includes(:user).order(created_at: :asc)
    end
    
  end
  