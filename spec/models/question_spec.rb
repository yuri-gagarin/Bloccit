require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { Question.create!(title: "Name of Question", body: "Question goes here", resolved: false) }

  describe "questions attributes" do
    it "has title, body and resolved attributes" do
      expect(question).to have_attributes(title: "Name of Question", body: "Question goes here", resolved: false)
    end
  end
end
