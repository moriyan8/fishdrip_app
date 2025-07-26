FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    email { Faker::Internet.unique.email }
    password { "password" }
    password_confirmation { "password" }

    # Sorcery の OAuth 認証を無効化（通常ログインの前提）
    after(:build) do |user|
      user.user_authentications = []
    end
  end
end
