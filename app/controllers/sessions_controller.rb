class SessionsController < ApplicationController
  def create
    email = params[:email]
    password = params[:password]
    remember = params[:remember_me] == "1"

    @user = login(email, password, remember_me: remember)

    if @user
      redirect_to root_path, notice: "ログインしました"
    else
      flash[:alert] = "ログイン出来ませんでした(￣ ￣)(メールアドレスまたはパスワードが間違っています)"
      redirect_to root_path
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "ログアウトしました"
  end
end
