class PostsController < ApplicationController
  # do not allow not signed in users to have an access to create post page
  before_action :redirect_if_not_signed_in, only: [:new] 
    def show
        @post = Post.find(params[:id])
    end
      def hobby
        posts_for_branch(params[:action])
      end
    
      def study
        posts_for_branch(params[:action])
      end
    
      def team
        posts_for_branch(params[:action])
      end 

      def new
        @branch = params[:branch]
        @categories = Category.where(branch: @branch)
        @post = Post.new
      end
    
      def create
        @post = Post.new(post_params)
        if @post.save 
          redirect_to post_path(@post) 
        else
          redirect_to root_path
        end
      end

  private
  def post_params
    params.require(:post).permit(:content, :title, :category_id)
                         .merge(user_id: current_user.id)
  end
  def posts_for_branch(branch)
    @categories = Category.where(branch: branch)
    @posts = get_posts.paginate(page: params[:page])
  end 
   
  def get_posts
    # logic moved to a service object
    PostsForBranchService.new({
      search: params[:search],
      category: params[:category],
      branch: params[:action]
    }).call
  end
   
end
