class ApplicationController < ActionController::Base
    def redirect_if_not_signed_in
        redirect_to root_path if !user_signed_in?
      end
      
      def redirect_if_signed_in
        redirect_to root_path if user_signed_in?
      end
end
