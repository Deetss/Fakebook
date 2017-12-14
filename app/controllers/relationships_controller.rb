class RelationshipsController < ApplicationController
  def index
  end
  
  def accept
    @request = Relationship.find(params[:req])
    @request.update_attributes(accepted: true)
    render :index
  end
end
