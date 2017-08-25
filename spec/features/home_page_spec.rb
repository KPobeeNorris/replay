require 'spec_helper'
feature 'Viewing links' do

  scenario 'I can see existing links on the links page' do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')

    visit '/links'
    expect(page.status_code).to eq 200
    expect(page).to have_content('Makers Academy')
  end

  scenario 'I can visit the home page' do
    visit '/'
    expect(page.status_code).to eq 200
  end
end
