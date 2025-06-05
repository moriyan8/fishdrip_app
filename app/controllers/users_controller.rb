class UsersController < ApplicationController
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
      redirect_to root_path, notice: "ユーザー登録が完了しました"
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
      redirect_to @user, notice: "ユーザー名を更新しました"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
