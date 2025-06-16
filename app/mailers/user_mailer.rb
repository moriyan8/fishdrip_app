class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url = activate_users_url(token: user.activation_token)
    mail(to: @user.email, subject: '【FishDrip】メールアドレスの確認をお願いします')
  end

  def activation_success_email(user)
    @user = user
    mail(to: @user.email, subject: '【FishDrip】アカウントが有効化されました')
  end
end
