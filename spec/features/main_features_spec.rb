require 'rails_helper'

RSpec.describe "Main Features", type: :feature do
#User Story: As an unauthenticated user, I can view all bars in my area.
  describe "viewing bars" do
    context "as unauthenticated user" do
      specify "can view all bars" do
        a_bar = create(:bar,
                       name: "Sid's Bar",
                       description: "A very cool bar")
        visit '/bars'

        expect(page).to have_content a_bar.name
        expect(page).to have_content a_bar.description
      end
    end
  end

#User Story: As an authenticated user,
#I can add myself to a bar to indicate I am going there tonight.
  describe "attending bars" do
    context "as an authenticated user" do
      specify "can indicate attendance"
    end
  end

#User Story: As an authenticated user,
#I can remove myself from a bar if I no longer want to go there.

#User Story: As an unauthenticated user,
#when I login I should not have to search again.
end
