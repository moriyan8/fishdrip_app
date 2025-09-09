class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @q = Post.ransack(params[:q])
    posts = @q.result(distinct: true).includes(:user).where(status: :post).order(fishing_date: :desc)

    if params[:keyword].present?
      posts = posts.search_keyword(params[:keyword])
    end

    @posts = posts.order(fishing_date: :desc).page(params[:page]).per(15)
  end
end
