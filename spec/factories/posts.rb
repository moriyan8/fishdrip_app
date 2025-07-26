FactoryBot.define do
  factory :post do
    fish_name { "アジ" }
    fishing_date { Time.zone.now }
    fish_size { 30 }

    association :user

    after(:build) do |post|
      post.image.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/sample.png')),
        filename: 'sample.png',
        content_type: 'image/png'
      )
    end
  end
end
