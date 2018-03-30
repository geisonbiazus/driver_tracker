class DriverActivityReportInteractor
  def initialize(tracking_event_repository)
    @tracking_event_repository = tracking_event_repository
  end

  def generate(driver_id, date)
    events = @tracking_event_repository.find_by_driver_id_and_date(driver_id, date)
    [
      {
        from: events.first.timestamp,
        to: events.first.timestamp,
        activity: events.first.activity,
        time: 0
      }
    ]
  end
end
