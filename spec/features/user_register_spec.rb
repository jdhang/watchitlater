require 'spec_helper'

feature 'User Register' do
  scenario "with valid inputs" do
    visit register_path
    fill_in "Username", with: "testdummy"
    fill_in "First Name", with: "test"
    fill_in "Last Name", with: "dummy"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_button "Register"
    expect(page).to have_content "Unwatched Movies"
  end
  scenario "with invalid inputs" do
    visit register_path
    fill_in "Username", with: "testdummy"
    fill_in "First Name", with: "test"
    fill_in "Last Name", with: "dummy"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password1"
    click_button "Register"
    expect(page).to have_content "The following errors"
  end
end
