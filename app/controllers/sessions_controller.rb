class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new, :create ]

  def new
    # ログイン画面表示用
  end

  def create
    email = params[:email]
    password = params[:password]
    remember = params[:remember_me] == "1"

    @user = login(email, password, remember_me: remember)

    if @user
      if !@user.intro_seen?
        session[:show_intro_modal] = true
        @user.update(intro_seen: true)
      end

      redirect_to root_path, notice: "ログインしました"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません。"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "ログアウトしました"
  end
end
