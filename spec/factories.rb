FactoryGirl.define do
  sequence(:email) { |n| "person#{n}@example.com" }
  sequence(:login) { |n| "user#{n}" }

  factory :user do
    login 
    email
  end
end

OmniAuth.config.mock_auth[:fake_john] = {
  'uid' => 'john',
  'user_info' => {
    'name'  => 'John Smith',
    'email' => 'john@example.com'
  }
}
