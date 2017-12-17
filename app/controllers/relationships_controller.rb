class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end
  
  def destroy
    @friendship = Relationship.find_by(requested: current_user) || Relationship.find_by(requestee: current_user)
    @friendship.destroy
    flash[:danger] = "You unfriended #{params[:user_name]}!"
    redirect_back(fallback_location: root_path)
  end
  
  def accept
    @request = Relationship.find_by(id: params[:req])
    @request.update_attributes(accepted: true)
    flash[:success] = "#{@request.requested.name} and you are now friends!"
    render :index
  end
  
  def request_friendship
    @requested_user = User.find(params[:req_user])
    @request = current_user.sent_requests.build(requested: @requested_user )
    
    if @request.save
      flash[:success] = 'Friend request sent'
      redirect_to @requested_user
    else
      flash.now[:danger] = 'Friend request not sent'
      render :show
    end
  end
  
end
