require 'rails_helper'

describe 'the new application form' do
  describe 'the new application' do
    it 'renders new form' do
      visit '/applications/new'

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip code')
    end
  end

  describe 'the application create' do
    it 'given valid data' do
      visit '/applications/new'

      fill_in 'Name', with: 'Natalie'
      fill_in 'Street address', with: '1234 Random St'
      fill_in 'City', with: 'Englewood'
      fill_in 'State', with: 'CO'
      fill_in 'Zip code', with: '80205'
      click_button 'Submit'

      app = Application.last

      expect(current_path).to eq("/applications/#{app.id}")
      expect(page).to have_content('Natalie')
      expect(page).to have_content('1234 Random St')
      expect(page).to have_content('Englewood')
      expect(page).to have_content('CO')
      expect(page).to have_content('80205')
      expect(page).to have_content('in_progress')
    end
  end
end
