class PostsController < ApplicationController
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

  private
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
