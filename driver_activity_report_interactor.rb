class DriverActivityReportInteractor
  def initialize(tracking_event_repository)
    @tracking_event_repository = tracking_event_repository
  end

  def generate(driver_id, date)
    events = @tracking_event_repository.find_by_driver_id_and_date(driver_id, date)
    report = DriverActivityReport.new
    report.driver_id = driver_id
    report.date = date
    report.rows = []

    events.each do |event|
      last = report.rows.last
      if last && last.activity == event.activity
        last.to = event.timestamp
      else
        report.rows << DriverActivityReport::Row.new(
          event.timestamp, event.timestamp, event.activity
        )
      end
    end
    report
  end
end
