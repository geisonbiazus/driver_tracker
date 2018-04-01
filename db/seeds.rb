# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts 'Loading sample data...'

company = Company.create(field: [[10, 10], [10, 20], [20, 20], [20, 10], [10, 10]])

base_time = '2018-04-01 8:00'.to_time

every_min_for_12_hours = 12 * 60

1.upto(every_min_for_12_hours) do |i|
  DriverTracker.add_event_interactor.run(
    company_id: company.id,
    driver_id: 1,
    timestamp: base_time + i * 60,
    latitude: Random.rand(0.0..50.0),
    longitude: Random.rand(0.0..50.0),
    accuracy: 12,
    speed: Random.rand(0.0..10.0)
  )
end

puts 'All done, you can test the report with driver_id = 1 and date = 2018-04-01'
