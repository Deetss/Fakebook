class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Something prevented the comment from being posted"
    end
    
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    
    if @comment.delete
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Something prevented the comment from being deleted"
    end
  end
  
  
  private
  
  def comment_params
    params.require(:comment).permit(:user_id, :content, :post_id)
  end
end
