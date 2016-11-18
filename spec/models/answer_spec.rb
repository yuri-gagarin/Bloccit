require 'rails_helper'

RSpec.describe Answer, type: :model do
  let (:question) { Question.create!(title: "Question Title", body: "The actual question", resolved: false) }
  let (:answer) {Answer.create!(body: "Answer to the question", question: question) }

  describe "answer attributes" do
    it "will have a body attribute" do
      expect(answer).to have_attributes(body: "Answer to the question")
    end
  end
end
