# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts 'Loading sample data...'

def add_random_data_for(base_time, company, driver_id)
  every_min_for_8_hours = 8 * 60

  1.upto(every_min_for_8_hours) do |i|
    DriverTracker.add_event_interactor.run(
      company_id: company.id,
      driver_id: driver_id,
      timestamp: base_time + i * 60,
      latitude: Random.rand(0.0..50.0),
      longitude: Random.rand(0.0..50.0),
      accuracy: 12,
      speed: Random.rand(0.0..10.0)
    )
  end
end

def add_data_based_on_ranges(
    from, to, company, driver_id, latitude_range, longitude_range, speed_range
  )
  current_time = from
  while current_time < to
    DriverTracker.add_event_interactor.run(
      company_id: company.id,
      driver_id: driver_id,
      timestamp: current_time,
      latitude: Random.rand(latitude_range),
      longitude: Random.rand(longitude_range),
      accuracy: 12,
      speed: Random.rand(speed_range)
    )
    current_time += 60
  end
end

def add_repairing_data(from, to, company, driver_id)
  add_data_based_on_ranges(from, to, company, driver_id, (11..19), (11..19), (0.0..0.9))
end

def add_driving_data(from, to, company, driver_id)
  add_data_based_on_ranges(from, to, company, driver_id, (21..29), (21..29), (5.0..10.0))
end

def add_cultivating_data(from, to, company, driver_id)
  add_data_based_on_ranges(from, to, company, driver_id, (11..19), (11..19), (1.0..10.0))
end

def add_structured_data_for(base_time, company, driver_id)
  add_repairing_data(base_time, base_time + 1.hour, company, driver_id)
  add_driving_data(base_time + 1.hour, base_time + 3.hour + 20.minutes, company, driver_id)
  add_repairing_data(base_time + 3.hours + 20.minutes, base_time + 6.hours, company, driver_id)
  add_cultivating_data(base_time + 6.hours, base_time + 10.hours, company, driver_id)
  add_driving_data(base_time + 10.hours, base_time + 10.hour + 1.minute, company, driver_id)
  add_cultivating_data(base_time + 11.hours, base_time + 12.hours + 11.minutes, company, driver_id)
end

company = Company.create(field: [[10, 10], [10, 20], [20, 20], [20, 10], [10, 10]])

add_random_data_for('2018-04-01 8:00'.to_time, company, 2)
add_structured_data_for('2018-04-01 8:00'.to_time, company, 1)
add_random_data_for('2018-04-02 8:00'.to_time, company, 1)
add_structured_data_for('2018-04-02 8:00'.to_time, company, 2)

puts 'All done, you can test the report with driver_id = 1 and date = 2018-04-01'
