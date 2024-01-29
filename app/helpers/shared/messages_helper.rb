module Shared::MessagesHelper

    def append_previous_messages_partial_path
      'shared/load_more_messages/window/append_messages' 
    end
    
      # if there are no previous messages
  def remove_link_to_messages
    if @is_messenger == 'false'
      if @messages_to_display_offset != 0
        'shared/empty_partial'
      else
        'shared/load_more_messages/window/remove_more_messages_link' 
      end
    else
      'shared/empty_partial'
    end
  end

end