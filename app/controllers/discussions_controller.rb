class DiscussionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_discussion, only: %i[show edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @pagy, @discussions = pagy(Discussion.includes(:category).discussions_order)
  end

  def show
    @pagy, @posts = pagy(@discussion.posts.includes(:user, :rich_text_body).order(created_at: :asc))
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

        DiscussionBroadcaster.new(@discussion).broadcast!
        format.html { redirect_to @discussion, notice: 'Discussion updated' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @discussion.destroy!
    respond_to do |format|
      format.html { redirect_to discussions_path, notice: 'Discussion removed' }
    end
  end

  private

  def discussion_params
    params.require(:discussion).permit(:name, :category_id, :pinned, :closed, posts_attributes: :body)
  end

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

  def not_found
    flash[:notice] = 'The discussion you tried to access does not exist. It may have been deleted'
    redirect_to discussions_path
  end
end
