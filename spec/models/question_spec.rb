require 'rails_helper'

RSpec.describe Comment do
  let(:question) { Question.create(body: "New Question Body", resolved: true) }

  describe "attributes" do
    it "has a body atttribute" do
      expect(question).to have_attributes(body: "New Question Body", resolved: true)
    end
  end
end
