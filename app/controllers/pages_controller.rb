class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :check_policy_agreement

  def terms
  end

  def privacy
  end
end
