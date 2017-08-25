require 'spec_helper'
feature 'Creating new links' do

  scenario 'I can create a new link' do
    visit '/links/new'
    fill_in 'title', with: "Staggering beauty"
    fill_in 'url', with: "http://www.staggeringbeauty.com/"

    click_button 'Submit'

    expect(page.status_code).to eq 200
    expect(current_path).to eq '/links'
    expect(page).to have_content('Staggering beauty')
  end

  scenario 'I can add a tag to a link' do
    visit '/links/new'
    fill_in 'title', with: "Staggering beauty"
    fill_in 'url', with: "http://www.staggeringbeauty.com/"
    fill_in 'name', with: "Random"

    click_button 'Submit'
    link = Link.first
    expect(link.tags.map(&:name)).to include('Random')
  end

  scenario 'Add multiple tags to a link'do
  visit '/links/new'
  fill_in 'title', with: "Staggering beauty"
  fill_in 'url', with: "http://www.staggeringbeauty.com/"
  fill_in 'name', with: "random fun"

  click_button 'Submit'

  expect(page.status_code).to eq 200
  expect(current_path).to eq '/links'
  expect(page).to have_content('random, fun')
  end
end

feature 'Viewing links' do

  before(:each) do
      Link.create(url: 'http://www.corndogoncorndog.com', title: 'Corn dog', tags: [Tag.first_or_create(name: 'food')])
      Link.create(url: 'http://www.google.com', title: 'Google', tags: [Tag.first_or_create(name: 'search')])
      Link.create(url: 'http://www.tastytomatoes.com', title: 'This is tomatoes', tags: [Tag.first_or_create(name: 'food')])
      Link.create(url: 'http://www.staggeringbeauty.com', title: 'Staggering beauty', tags: [Tag.first_or_create(name: 'random')])
    end

  scenario 'Filter links by tag' do
    visit 'tags/random'
    expect(page.status_code).to eq(200)
    expect(page).to have_content('Staggering beauty')
    expect(page).not_to have_content('Corn dog')
  end
end
