module Features
  module SessionsHelper
    def sign_up_with(email, password)
      visit new_user_registration_path

      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password
      click_button 'Sign up'
    end

    def sign_in_with(email, password)
      visit new_user_session_path

      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      click_button 'Sign in'
    end

    def sign_in
      user = FactoryGirl.create(:user)
      visit new_user_session_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Sign in'
    end
  end
end
