class SessionsController < ApplicationController
  def create
    email = params[:email]
    password = params[:password]
    remember = params[:remember_me] == "1"

    @user = login(email, password, remember_me: remember)

    if @user
      redirect_to root_path, notice: "ログインしました"
    else
      user = User.find_by(email: params[:email])
      flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません。"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "ログアウトしました"
  end
end
