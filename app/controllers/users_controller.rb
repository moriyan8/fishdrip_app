class UsersController < ApplicationController
  def new
    @user = User.new
    @hide_header = true
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "ユーザー登録が完了しました"
    else
      @hide_header = true
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
