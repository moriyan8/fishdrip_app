class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @posts = Post.includes(:user).where(status: :post).order(fishing_date: :desc)
  end
end
