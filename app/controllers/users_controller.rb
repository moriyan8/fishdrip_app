class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @user = User.new
    @hide_header = true
  end

  def show
    redirect_to root_path unless params[:id].to_i == current_user.id
    @user = current_user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "ユーザー登録に成功しました。"
    else
      @hide_header = true
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user, notice: "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # def activate
  #  @user = User.load_from_activation_token(params[:token])

  #  if @user
  #    @user.activate!
  #    redirect_to login_path, notice: "アカウントを有効化しました！ログインしてください。"
  #  else
  #    redirect_to root_path, alert: "有効化リンクが無効または期限切れです。"
  #  end
  # end

  # def resend_activation
  #  user = User.find_by(email: params[:email])
  #  if user && user.activation_state != 'active'
  #    user.setup_activation if user.activation_token.blank?
  #    user.deliver_activation_email!
  #    redirect_to login_path, notice: "確認メールを再送しました。メールをご確認ください。"
  #  else
  #    redirect_to login_path, alert: "再送できません。すでに有効化済み、または該当するメールアドレスが見つかりませんでした。"
  #  end
  # end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
