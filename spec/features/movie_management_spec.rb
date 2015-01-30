require 'spec_helper'

feature "Movie management" do
  let!(:bob) { Fabricate(:user, first_name: "Bob") }
  let!(:movie) { Fabricate(:movie, title: "Avatar", user: bob) }
  scenario "User create a new movie", :js => true do
    login(bob)

    click_link "Add Movie"

    fill_in "Movie Title", with: "Avatar"
    click_button "+"

    expect(page).to have_content "Avatar"
  end
  scenario "User edits movie", :js => true do
    login(bob)

    click_link "Avatar"

    fill_in "Movie Title", with: "Inception"
    click_button "+"

    expect(page).to have_content "Inception"
  end
end
