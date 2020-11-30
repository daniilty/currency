require "rails_helper"
feature "Checking the main page content" do
  background do
    @dt = DateTime.now
    Curr.create(current: '24') 
  end
  scenario "checking the correct content on a home page" do
    visit '/admin'
    within("#new_forced") do
      fill_in "Select the next forced rate date", with: @dt + 3.days
      fill_in "Select the next forced rate value", with: "10"
    end
    click_button "ok"
    expect(page).to have_content "All fine"
  end
  scenario "checking if the page content is returning an error" do
    visit "/admin"
    within("#new_forced") do
      fill_in "Select the next forced rate value", with: "10"
    end
    click_button "ok"
    expect(page).to have_content "You must provide date to process the form"
  end

end
