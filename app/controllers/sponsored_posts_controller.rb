class SponsoredPostsController < ApplicationController
  def show
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = SponsoredPost.new
  end

  def edit
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = SponsoredPost.new
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]
    @sponsored_post.price = params[:sponsored_post][:price]
    @sponsored_post.topic = @topic

    if @sponsored_post.save
      flash[:message] = "The sponsored post was saved!"
      redirect_to ([@topic, @sponsored_post])
    else
      flash.now[:alert] = "Error saving your post. Please try again!"
      render new
    end
  end

  def update
    @sponsored_post = SponsoredPost.find(params[:id])
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]
    @sponsored_post.price = params[:sponsored_post][:price]
    @topic = @sponsored_post.topic

    if @sponsored_post.save
      flash[:notice] = "The sponsored post was saved!"
      redirect_to ([@topic, @sponsored_post])
    else
      flash.now[:alert] = "Error saving your post. Please try again!"
      render :new
    end
  end

  def destroy
    @sponsored_post = SponsoredPost.find(params[:id])

    if @sponsored_post.destroy
      flash[:notice] = "The post \"#{@sponsored_post.title}\" was deleted!"
      redirect_to (@sponsored_post.topic)
    else
      flash.now[:alert] = "Error deleting the post. Please try again!"
      render :show
    end
  end


end
