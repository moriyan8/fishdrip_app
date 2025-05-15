class User < ApplicationRecord
  has_many :posts, dependent: :destroy


  authenticates_with_sorcery!
  #ユーザーが設定したパスワードの長さが3文字以上であることを確認
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  #ユーザーが設定したパスワードと確認用のパスワードが一致していることを確認
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  #確認用パスワードの入力が存在することを確認
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  #新規にユーザーが登録された際に、emailが存在するか、登録済みかどうかを確認
  validates :email, uniqueness: true, presence: true
  #新規にユーザーが登録された際に、nameが存在するかどうかの確認と文字数の制限
  validates :name, presence: true, length: { maximum: 255 }
end
#confirmationは、2つの属性の値が一致するかどうかを検証
#presenceは、指定された属性が存在しているかどうかを検証
