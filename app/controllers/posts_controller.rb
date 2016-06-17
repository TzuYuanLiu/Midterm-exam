class PostsController < ApplicationController
	before_action :set_post, :only => [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, :except => [:index, :show]



  def index



      if params[:order] == "last_comment_time"
        @posts = Post.page( params[:page]).per(4).order("last_comment_time desc")
      elsif params[:order] && params[:order] == "comment_count"
        @posts = Post.page( params[:page]).per(4).order("comments_count desc")
      elsif params[:order] && params[:order] == "topic_clicks"
        @posts = Post.page( params[:page]).per(4).order("clicked desc")
      else
        @posts = Post.page( params[:page]).per(4).order(":id desc")
      end
    


  	
  end	

  def new
  	@post = Post.new
  end

  def create
	  @post = current_user.posts.build(post_params)
		if @post.save
			
	  	redirect_to @post
	  	flash[:notice] = "Post was successfully created"
		else
			flash[:alert] = "Title can not be blank"
			render :new
		end
  end
 
  def show
    @comment = Comment.new
  end

  def edit
    unless @post.user == current_user
      flash[:alert] = "No-Access-Edit-Allow"
      redirect_to :root
    end
  end

  def update
    if @post.update(post_params)
    	flash[:notice] = "Post was successfully updated"
      redirect_to @post
    else
    	render :edit  
 		end
  end

  def destroy
    unless @post.user == current_user
      flash[:alert] = "No-Access-Delete-Allow" 
      redirect_to :root
    else
      flash[:alert] = "Post was successfully deleted"
      @post.destroy
      redirect_to :root
    end  
  end

  protected

  def set_post
  	@post = Post.find(params[:id])
  end

  def post_params
  	params.require(:post).permit(:title, :content)
  end

end
