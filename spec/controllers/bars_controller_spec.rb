require 'rails_helper'

RSpec.describe BarsController, type: :controller do
  describe "#attend" do
    it "increments attendee count" do
      a_bar = create(:bar)
      post :attend, bar_id: a_bar.id

      expect(Bar.first.attendees).to eq 1
    end
  end
end
