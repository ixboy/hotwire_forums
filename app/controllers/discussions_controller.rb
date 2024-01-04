class DiscussionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_discussion, only: %i[show edit update destroy]

  def index
    @discussions = Discussion.all.order(updated_at: :desc)
  end

  def show
    @new_post = @discussion.posts.new
  end

  def new
    @discussion = Discussion.new
    @discussion.posts.new
  end

  def create
    @discussion = Discussion.new(discussion_params)

    respond_to do |format|
      if @discussion.save
        format.html { redirect_to @discussion, notice: 'Discussion created successfully' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @discussion.update(discussion_params)
        @discussion.broadcast_replace(partial: 'discussions/header', discussion: @discussion)
        format.html { redirect_to @discussion, notice: 'Discussion updated successfully' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @discussion.destroy!
    # byebug
    respond_to do |format|
      format.html { redirect_to discussions_path, notice: 'Discussion removed' }
    end
  end

  private

  def discussion_params
    params.require(:discussion).permit(:name, :pinned, :closed, posts_attributes: :body)
  end

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end
end
