class DriverActivityReportInteractor
  def initialize(tracking_event_repository)
    @tracking_event_repository = tracking_event_repository
  end

  def generate(driver_id, date)
    events = @tracking_event_repository.find_by_driver_id_and_date(driver_id, date)
    report = DriverActivityReport.new
    report.driver_id = driver_id
    report.date = date
    report.rows = [
      DriverActivityReport::Row.new(events.first.timestamp, events.last.timestamp, events.first.activity)
    ]
    report
  end
end
