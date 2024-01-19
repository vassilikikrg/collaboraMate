require "rails_helper"

RSpec.feature "Visit single post", :type => :feature do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  scenario "User goes to a single post from the home page", js: true do
    post
    visit root_path
    page.find('.interested a').click
    expect(page).to have_selector('.post-container p', text: post.content)
  end

end