class PostsController < ApplicationController
    before_action :authenticate_user!
    def create
        @post = Post.new(post_params)
        if @post.save
            flash[:success] = "Post successfully created!"
            redirect_back(fallback_location: root_path)
        else
            flash[:danger] = "Post was not created!"
            redirect_back(fallback_location: root_path)
        end
    end
    
        
    def destroy
        @post = Post.find(params[:id])
        if @post.delete
            flash[:success] = "Post deleted!"
            redirect_back(fallback_location: root_path)
        else
            flash[:danger] = "Something prevented the post from being deleted"
            redirect_back(fallback_location: root_path)
        end
    end
    
    def post_params
        params.require(:post).permit(:content, :user_id, :image_link, :image)
    end

end
