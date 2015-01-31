require 'spec_helper'

feature "User login" do
  scenario "with valid credentials" do
    bob = Fabricate(:user, first_name: "Bob")
    login(bob)
    expect(page).to have_content "Unwatched Movies"
  end
  scenario "with invalid credentials" do
    bob = Fabricate(:user)
    visit root_path
    fill_in "Username", with: bob.username
    fill_in "Password", with: "test"
    click_button "Login"
    expect(page).to have_content "Your username or password was incorrect."
  end
end
