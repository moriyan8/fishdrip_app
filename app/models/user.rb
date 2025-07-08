class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :user_authentications, dependent: :destroy
  accepts_nested_attributes_for :user_authentications

  has_many :posts, dependent: :destroy

  def using_oauth?
    user_authentications.any? || self.user_authentications_attributes&.any?
  end

  validates :password, length: { minimum: 5 }, unless: :using_oauth?
  validates :password, confirmation: true, unless: :using_oauth?
  validates :password_confirmation, presence: true, unless: :using_oauth?
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 20 }, unless: :using_oauth?
end

# メール機能、実装予定日遅らせます。
  # def deliver_activation_email!
  #   UserMailer.activation_needed_email(self).deliver_now
  # end
