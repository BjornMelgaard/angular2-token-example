module EmailMacroses
  def follow_reset_password_email(user_email)
    open_email(user_email)
    current_email.click_link 'Change my password'
  end
end

RSpec.configure do |config|
  config.include EmailMacroses, type: :feature
end
