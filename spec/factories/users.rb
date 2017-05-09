require 'faker'

FactoryGirl.define do
  password = Faker::Internet.password
  email = Faker::Internet.email
  timestamp = DateTime.parse(2.weeks.ago.to_s).to_time.strftime("%F %T")

  factory :user do
    uid                   { email }
    email                 { email }
    provider              'email'
    created_at            { timestamp }
    updated_at            { timestamp }
    password              { password }
  end
end
