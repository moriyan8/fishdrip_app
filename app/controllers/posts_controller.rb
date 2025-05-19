class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to root_path, notice: '投稿が完了しました！'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(
      :image, :fish_name, :fish_size, :spot, :spot_detail,
      :fishing_date, :weather, :temperature, :tide,
      :comment, :memo, :status, :latitude, :longitude
    )
  end
end
