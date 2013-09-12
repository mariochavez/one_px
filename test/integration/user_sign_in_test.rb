require 'test_helper'

feature 'User Sign In' do
  scenario 'automatically after registration' do
    visit '/signup'

    within('#new_user') do
      fill_in 'Email', with: 'user@sample.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'

      click_button 'Crear User'
    end

    page.must_have_content 'Welcome aboard'
  end

  scenario 'fail to singup user when form is empty' do
    visit '/signup'

    click_button 'Crear User'

    page.must_have_selector '.notice', text: 'Ohh tenemos 2 errores'
    all('.error').count.must_equal 2
  end
end
