class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  validates :image, presence: true
  validates :fish_name, presence: true
  validates :fishing_date, presence: true

  enum weather: { sunny: 0, cloudy: 1, rainy: 2, snowy: 3 }
  enum status: { post: 0, record: 1 }
end
