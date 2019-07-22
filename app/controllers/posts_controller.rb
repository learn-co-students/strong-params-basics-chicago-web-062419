class PostsController < ApplicationController
	def index
		@posts = Post.all
	end

	def show
		@post = Post.find(params[:id])
	end

	def new
		@post = Post.new
	end


    # require - requires value passed in to have a key of "post".
    # permit - allows for either "title" or "description" keys. Anything else will no get stored.
    # So in this case it must be a post, with another key of title and/or description.

        
    def create
        # @post = Post.new(params.require(:post).permit(:title, :description))
        @post = Post.new(post_params(:title, :description))
        @post.save
        redirect_to post_path(@post)
    end


    def update
        # @post.update(params.require(:post).permit(:title))
        @post = Post.find(params[:id])
        @post.update(post_params(:title))
        redirect_to post_path(@post)
    end


	def edit
	    @post = Post.find(params[:id])
	end
end

private
    
    # Initial abstraction.
    # def post_params
    #     params.require(:post).permit(:title, :description)
    # end

    # Because #update only allowed (:title) to be updated, while #create allowed for :title & :description, using the splat operator.
    def post_params(*args)
        params.require(:post).permit(*args)
    end