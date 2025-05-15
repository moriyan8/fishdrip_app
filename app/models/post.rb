class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  enum weather: { sunny: 0, cloudy: 1, rainy: 2, snowy: 3 }
  enum status: { post: 0, record: 1 }
end
