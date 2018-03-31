FactoryBot.define do
  factory :activity_event do
    company nil
    driver_id 1
    timestamp "2018-03-31 13:02:32"
    latitude 1.5
    longitude 1.5
    accuracy 1.5
    speed 1.5
    activity "MyString"
  end
end
