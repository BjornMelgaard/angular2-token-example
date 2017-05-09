feature 'Authentication:' do
  context 'login' do
    before do
      visit '/#/session/sign-in'
      expect(page).to have_current_path '/#/session/sign-in'
    end

    scenario 'when invalid' do
      user = attributes_for :user
      require 'pry'; ::Kernel.binding.pry;
      within('form') do
        fill_in 'email', with:    user[:email]
        fill_in 'password', with: user[:password]
      end
      click_button 'Submit'
      expect(page).to have_content 'Invalid login credentials. Please try again'
    end

    scenario 'when valid' do
      user = create :user
      within('form') do
        fill_in 'email', with:    user.email
        fill_in 'password', with: user.password
      end
      click_button 'Submit'
      expect(page).to have_current_path '/'
    end
  end

  context 'registration' do
    before do
      visit '/'
      click_on 'Sign Up'
      expect(page).to have_current_path '/auth/sign-up'
    end

    scenario 'when valid' do
      expect do
        user = attributes_for :user
        within('form') do
          fill_in 'email', with:                user[:email]
          fill_in 'password', with:             user[:password]
          fill_in 'passwordConfirmation', with: user[:password_confirmation]
        end
        click_button 'Submit'
        expect(page).to have_current_path '/'
      end.to change(User, :count).by(1)
    end

    scenario 'when user exists' do
      user = create :user
      within('form') do
        fill_in 'email', with:                user.email
        fill_in 'password', with:             user.password
        fill_in 'passwordConfirmation', with: user.password
      end
      click_button 'Submit'
      expect(page).to have_content 'Email has already been taken'
    end
  end

  scenario 'reset password flow' do
    user = create :user

    visit '/'
    click_on 'Forgot Password?'
    expect(page).to have_current_path '/auth/reset-password'

    within('form') do
      fill_in 'email', with: user.email
    end
    click_button 'Submit'
    expect(page).to have_content 'email has been sent'
    expect(page).to have_current_path '/auth/reset-password'

    follow_reset_password_email(user.email)
    # FIXME: in angular2-token getAuthDataFromParams is running when no params
    # https://github.com/neroniaky/angular2-token/blob/master/src/angular2-token.service.ts#L483
    # expect(page).to have_current_path '/auth/update-password'
  end

  # FIXME
  # scenario 'facebook auth' do
  #   user = build :user
  #   mock_facebook(user)
  #   visit '/'
  #   click_on 'Sign In with Facebook'
  # end
end
