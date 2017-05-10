Devise.setup do |config|
  # For omniauth https://github.com/lynndylanhurley/devise_token_auth/issues/830
  config.parent_controller = 'ActionController::Base'
end
