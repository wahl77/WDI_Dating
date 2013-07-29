# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "franky"
    password "franky"
    factory :paid_user do
      paid true
    end
  end
end
