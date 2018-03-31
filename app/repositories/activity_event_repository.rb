class ActivityEventRepository
  def create(event)
    ActivityEvent.create!(
      company_id: event.company_id,
      driver_id: event.driver_id,
      timestamp: event.timestamp,
      latitude: event.latitude,
      longitude: event.longitude,
      accuracy: event.accuracy,
      speed: event.speed,
      activity: event.activity
    )
  end

  def find_all_by_driver_id_and_date_sorted_by_timestamp(driver_id, date)
    ActivityEvent.where(
      driver_id: driver_id, timestamp: [date.beginning_of_day..date.end_of_day]
    ).order(:timestamp)
  end
end
