class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  authenticates_with_sorcery!

  #ユーザーが設定したパスワードの長さが5文字以上であることを確認
  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  #ユーザーが設定したパスワードと確認用のパスワードが一致していることを確認
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  #確認用パスワードの入力が存在することを確認
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  #新規にユーザーが登録された際に、emailが存在するか、登録済みかどうかを確認
  validates :email, uniqueness: true, presence: true
  #新規にユーザーが登録された際の文字数の制限
  validates :name, length: { maximum: 20 }

  # メール機能、実装予定日遅らせます。
  # def deliver_activation_email!
  #   UserMailer.activation_needed_email(self).deliver_now
  # end
end
