require 'spec_helper'
feature 'Including Users' do

  scenario 'Create a new user' do
    visit '/users/new'
    fill_in 'first_name', with: 'Bob'
    fill_in 'surname', with: 'Belcher'
    fill_in 'email', with: 'bob@burgers.com'
    fill_in 'password', with: 'ilovelynda'
    click_button 'Submit'

    expect(current_path).to eq('/links')
    expect(page).to have_content("Welcome bob@burgers.com")
    user = User.all
    expect(user.count).to eq(1)
  end

end
