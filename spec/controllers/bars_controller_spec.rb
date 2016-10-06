require 'rails_helper'

RSpec.describe BarsController, type: :controller do
  login_user

  describe "#attend" do
    it "increments attendee count" do
      a_bar = create(:bar)
      post :attend, bar_id: a_bar.id

      expect(Bar.first.users.count).to eq 1
    end
  end

  describe "#search" do
    it "calls the yelp api" do
      expect(a_request(:post, "www.example.com").
             with(body: "abc", headers: {'Content-Length' => 3})).
      to have_been_made.once
    end
  end
end
