class AddActivityEventJob < ApplicationJob
  queue_as :default

  def perform(data)
    DriverTracker.add_event_interactor.run(event_attributes(data))
  end

  private

  def event_attributes(data)
    {
      company_id: data[:company_id].to_i,
      driver_id: data[:driver_id].to_i,
      timestamp: parse_timestamp(data[:timestamp]),
      latitude: data[:latitude].to_f,
      longitude: data[:longitude].to_f,
      accuracy: data[:accuracy].to_f,
      speed: data[:speed].to_f
    }
  end

  def parse_timestamp(timestamp)
    Time.parse(timestamp)
  rescue TypeError, ArgumentError
    nil
  end
end
