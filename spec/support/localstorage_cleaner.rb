RSpec.configure do |config|
  config.after(:example, type: :feature) do
    Capybara.execute_script <<-EOF
    if (!location.hostname.length > 0) throw "Please enable client"
    localStorage.clear()
    EOF
  end
end
