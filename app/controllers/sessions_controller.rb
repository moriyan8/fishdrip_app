class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    email = params[:email]
    password = params[:password]
    remember = params[:remember_me] == "1"

    @user = login(email, password, remember_me: remember)

    if @user
      if @user.respond_to?(:intro_seen) && !@user.intro_seen?
        session[:show_intro_modal] = true
        @user.update(intro_seen: true)
      elsif !@user.respond_to?(:intro_seen)
        session[:show_intro_modal] = true
      end

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
