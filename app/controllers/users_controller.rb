class UsersController < ApplicationController
    before_action :authenticate_user!
    
    
    def search
        @q = "#{params[:q]}"
        @results = User.all.where("name ILIKE ? or email ILIKE ?", @q, @q)
        render :search
    end
    
    def show
        @user = User.find(params[:id])
        @friends = @user.friends
    end
end
