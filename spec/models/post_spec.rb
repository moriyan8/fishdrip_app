require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーション' do
    it 'すべての項目があれば有効である' do
      post = build(:post)
      expect(post).to be_valid
    end

    it '魚種がないと無効である' do
      post = build(:post, fish_name: nil)
      expect(post).not_to be_valid
    end

    it '釣行日時がないと無効である' do
      post = build(:post, fishing_date: nil)
      expect(post).not_to be_valid
    end

    it '画像がないと無効である' do
      post = build(:post)
      post.image.detach
      expect(post).not_to be_valid
    end
  end
end
