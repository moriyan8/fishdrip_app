class HomeController < ApplicationController

  def index
    @posts = Post.includes(:user).where(status: :post).order(fishing_date: :desc)
  end
end
