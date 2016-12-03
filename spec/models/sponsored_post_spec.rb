require 'rails_helper'
include RandomData

RSpec.describe SponsoredPost, type: :model do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:title) {"Best Thing Ever!"}
  let(:body) {"You really want this! You really do! All your troubles will go away!"}
  let(:price) {999}
  let(:ad_post) {topic.sponsored_posts.create!(title: title, body: body, price: price)}

  it { is_expected.to belong_to(:topic) }

  describe "attributes" do
    it "has title, body, and price attributes" do
      expect(ad_post).to have_attributes(title: title, body: body, price: price)
    end
  end
end
