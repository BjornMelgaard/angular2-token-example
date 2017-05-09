module OmniauthMacroses
  def mock_facebook(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(
      :facebook,
      info: {
        email: user.email
      }
    )
  end
end

RSpec.configure do |config|
  config.include OmniauthMacroses, type: :feature
end
