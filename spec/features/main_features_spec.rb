require 'rails_helper'

RSpec.describe "Main Features", type: :feature do
  let!(:a_bar) do
   create(:bar,
          name: "Sid's Bar",
          description: "A very cool bar")
  end

  #User Story: As an unauthenticated user, I can view all bars in my area.
  describe "viewing bars" do
    context "as unauthenticated user" do
      specify "can view all bars" do
        visit '/bars'

        expect(page).to have_content a_bar.name
        expect(page).to have_content a_bar.description
      end
    end
  end

  #User Story: As an authenticated user,
  #I can add myself to a bar to indicate I am going there tonight.
  let!(:user) { FactoryGirl.create(:user) }

  describe "attending bars", js: true do
    context "as an authenticated user" do
      specify "increments going count" do
        login_as(user, :scope => :user)
        visit '/bars'
        find('a').click
        expect(page).to have_content('1 GOING')
      end

      specify "does not increment if already attending" do
        login_as(user, :scope => :user)
        visit '/bars'
        find('a').click
        expect(page).to have_content('1 GOING')
        find('a').click
        expect(page).to have_content('1 GOING')
      end
    end
  end

#User Story: As an authenticated user,
#I can remove myself from a bar if I no longer want to go there.

#User Story: As an unauthenticated user,
#when I login I should not have to search again.
end
