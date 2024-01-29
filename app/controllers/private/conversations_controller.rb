class Private::ConversationsController < ApplicationController
    # Creation of a new conversation
    def create
        recipient_id = Post.find(params[:post_id]).user.id
        @conversation = Private::Conversation.new(sender_id: current_user.id, 
                                                 recipient_id: recipient_id)
        if @conversation.save
          Private::Message.create(user_id: recipient_id, 
                                  conversation_id: @conversation.id, 
                                  body: params[:message_body])

          add_to_conversations unless already_added?
          
          respond_to do |format|
            format.js {render partial: 'posts/show/contact_user/message_form/success'}
          end
        else
          respond_to do |format|
            format.js {render partial: 'posts/show/contact_user/message_form/fail'}
          end
        end
      end

      private

      def add_to_conversations
        session[:private_conversations] ||= []
        session[:private_conversations] << @conversation.id
      end

      def already_added?
        # make sure that the conversation’s id isn’t added inside the session yet
        session[:private_conversations]&.include?(@conversation.id)
      end
end
