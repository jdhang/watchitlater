require 'spec_helper'

feature "Movie management" do
  scenario "User create a new movie", :js => true do
    bob = Fabricate(:user)
    login(bob)

    expect(page).to have_content "Unwatched Movies"

    click_link "Add Movie"

    fill_in "Movie Title", with: "Avatar"
    click_button "+"

    expect(page).to have_content "Avatar"
  end
  scenario "User edits movie", :js => true do
    bob = Fabricate(:user, first_name: "Bob")
    Fabricate(:movie, title: "Avatar", user: bob)
    login(bob)

    click_link "Avatar"

    fill_in "Movie Title", with: "Inception"
    click_button "+"

    expect(page).to have_content "Inception"
  end
end
