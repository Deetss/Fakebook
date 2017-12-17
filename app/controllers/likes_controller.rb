class LikesController < ApplicationController
    def like_object
        @post = Post.find(params[:post_id])
        @user = current_user
        
        @like = @user.likes.build(post: @post, liked: true)
        
        if @like.save
            redirect_back(fallback_location: root_path)
        else
            flash[:danger] = "Something went wrong!"
            redirect_back(fallback_location: root_path)
        end
        
    end
    
    def unlike_object
        @post = Post.find(params[:post_id])
        @like = @post.likes.where(post: @post, user: current_user)
        
        if @like.delete_all
            redirect_back(fallback_location: root_path)
        else
            flash[:danger] = "Something went wrong!"
            redirect_back(fallback_location: root_path)
        end
        
    end
end
