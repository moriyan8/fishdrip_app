require 'net/http'
require 'uri'
require 'json'

class OauthsController < ApplicationController
  skip_before_action :authenticate_user!

  def oauth
    redirect_to google_oauth_authorize_url, allow_other_host: true
  end

  def callback
    token_response = fetch_google_token(params[:code])

    if token_response["access_token"].present?
      user_info = fetch_google_user_info(token_response["access_token"])

      uid   = user_info["id"]
      email = user_info["email"]
      name  = user_info["name"]

      auth = UserAuthentication.find_by(provider: "google", uid: uid)

      if auth
        auto_login(auth.user)
      else
        begin
          user = User.create!(
            email: email,
            name: name.presence || "Google User #{uid}",
            user_authentications_attributes: [{
              provider: "google",
              uid: uid
            }]
          )
          auto_login(user)
        rescue ActiveRecord::RecordInvalid => e
          Rails.logger.error "ユーザー作成失敗: #{e.record.errors.full_messages.join(', ')}"
          redirect_to login_path, alert: "Googleログインに失敗しました: #{e.record.errors.full_messages.join(', ')}"
          return
        end
      end

      redirect_to root_path, notice: "Googleでログインしました"
    else
      redirect_to login_path, alert: "Googleログインに失敗しました"
    end
  end

  private

  def google_oauth_authorize_url
    client_id = ENV["GOOGLE_CLIENT_ID"]
    scope = "email profile"
    "https://accounts.google.com/o/oauth2/auth?" +
      URI.encode_www_form({
        client_id: client_id,
        redirect_uri: google_redirect_uri,
        response_type: "code",
        scope: scope
      })
  end

  def fetch_google_token(code)
    uri = URI("https://oauth2.googleapis.com/token")
    res = Net::HTTP.post_form(uri, {
      code: code,
      client_id: ENV["GOOGLE_CLIENT_ID"],
      client_secret: ENV["GOOGLE_CLIENT_SECRET"],
      redirect_uri: google_redirect_uri,
      grant_type: "authorization_code"
    })
    JSON.parse(res.body)
  end

  def fetch_google_user_info(access_token)
    uri = URI("https://www.googleapis.com/oauth2/v2/userinfo?access_token=#{access_token}")
    res = Net::HTTP.get(uri)
    JSON.parse(res)
  end

  def google_redirect_uri
    if Rails.env.production?
      "https://fishdrip.jp/oauth/callback?provider=google"
    else
      "http://localhost:3000/oauth/callback?provider=google"
    end
  end
end
