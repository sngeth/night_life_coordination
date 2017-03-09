require 'rails_helper'

RSpec.describe "Main Features", type: :feature do

  #User Story: As an unauthenticated user, I can view all bars in my area.

  before(:each) do
    stub_request(:get, "https://api.yelp.com/v2/search?limit=10&location=Jacksonville&term=bars")
      .to_return(body: File.read(Rails.root.to_s + "/spec/support/fixtures/search.json"))
  end

  describe "viewing bars" do
    context "as unauthenticated user" do
      specify "can search and view all bars" do
        visit '/'
        expect(page).to have_css('li.bar', count: 0)
        fill_in 'Location', with: "Jacksonville"
        click_button 'Go'
        expect(page).to have_css('li.bar', count: 10)
      end
    end
  end

  let!(:user) { FactoryGirl.create(:user) }

  context "as an authenticated user", js: true do
    #User Story: As an authenticated user,
    #I can add myself to a bar to indicate I am going there tonight.
    describe "attending bars" do
      it "increments going count" do
        login_as(user, scope: :user)
        visit '/'
        fill_in 'Location', with: "Jacksonville"
        click_button 'Go'

        within('.bar', text: 'Sidecar') do
          click_link('0 GOING')
        end

        expect(page).to have_content('1 GOING')
      end
    end

    #User Story: As an authenticated user,
    #I can remove myself from a bar if I no longer want to go there.
    describe "unattending bars" do
      it "decrements going count" do
        login_as(user, scope: :user)
        visit '/'
        fill_in 'Location', with: "Jacksonville"
        click_button 'Go'

        within('.bar', text: 'Sidecar') do
          click_link('0 GOING')
        end

        expect(page).to have_content('1 GOING')

        within('.bar', text: 'Sidecar') do
          click_link('1 GOING')
        end

        expect(page).to have_content('0 GOING')
      end
    end
  end

  describe "unattending bars", js: true do
  end

#User Story: As an unauthenticated user,
#when I login I should not have to search again.
end
