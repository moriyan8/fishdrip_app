class AgreementsController < ApplicationController
  skip_before_action :check_policy_agreement

  def show
  end

  def agree
    current_user.update(agreed_to_policy: true)

    if !current_user.intro_seen?
      session[:show_intro_modal] = true
      current_user.update!(intro_seen: true)
    end

    redirect_to root_path, notice: "ご同意ありがとうございました。"
  end
end
