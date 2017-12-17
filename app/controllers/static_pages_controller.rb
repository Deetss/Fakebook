class StaticPagesController < ApplicationController
    def home
        @feed = current_user.feed if user_signed_in?
    end
    
end
