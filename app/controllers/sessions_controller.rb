class SessionsController < ApplicationController
  def create
    email = params[:email]
    password = params[:password]
    remember = params[:remember_me] == "1"

    @user = login(email, password, remember_me: remember)

    if @user
      redirect_to root_path, notice: "ログインしました"
    else
      # Sorceryのloginがfalseを返した場合、ユーザーの取得を試みてエラーを特定
      user = User.find_by(email: params[:email])
      if user && user.activation_state != 'active'
        flash.now[:alert] = "アカウントが未有効です。確認メールが届いていない場合は、再送してください。"
        @resend_email = user.email
      else
        flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません。"
      end
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "ログアウトしました"
  end
end
