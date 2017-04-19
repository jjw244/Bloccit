require 'rails_helper'

RSpec.describe Comment do
  let(:question) { Question.create(body: "New Question Body", resolved: true) }
  let(:answer) { Answer.create!(body: 'Answer Body', question: question) }

  describe "attributes" do
    it "has a body atttribute" do
      expect(answer).to have_attributes(body: "Answer Body")
    end
  end
end
