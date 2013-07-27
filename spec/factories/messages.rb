# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    sender nil
    receiver nil
    content "MyText"
  end
end
