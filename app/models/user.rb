class User < ApplicationRecord
  authenticates_with_sorcery!

  attribute :agreed_to_policy, :boolean, default: false

  has_many :user_authentications, dependent: :destroy
  accepts_nested_attributes_for :user_authentications

  has_many :posts, dependent: :destroy

  has_many :favorites, dependent: :destroy

  def using_oauth?
    user_authentications.any? || (
      respond_to?(:user_authentications_attributes) && user_authentications_attributes&.any?
    )
  end

  def password_required?
    if new_record?
      !using_oauth?
    else
      password.present?
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.agreed_to_policy = false
    end
  end

  validates :password, length: { minimum: 5 }, confirmation: true, if: :password_required?
  validates :password, confirmation: true, unless: :using_oauth?
  validates :password_confirmation, presence: true, if: :password_required?
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 20 }, unless: :using_oauth?
end

# メール機能、実装予定日遅らせます。
# def deliver_activation_email!
#   UserMailer.activation_needed_email(self).deliver_now
# end
