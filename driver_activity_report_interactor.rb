class DriverActivityReportInteractor
  def initialize(tracking_event_repository)
    @tracking_event_repository = tracking_event_repository
  end

  def generate(driver_id, date)
    events = @tracking_event_repository
             .find_all_by_driver_id_and_date_sorted_chronologically(
               driver_id, date
             )
    report = DriverActivityReport.new(driver_id, date)
    generate_report_rows(report, events)
    report
  end

  private

  def generate_report_rows(report, events)
    events.each do |event|
      add_event_to_report(report, event)
    end
  end

  def add_event_to_report(report, event)
    last = report.rows.last
    if last && last.activity == event.activity
      last.to = event.timestamp
    else
      report.rows << create_report_row(event)
    end
  end

  def create_report_row(event)
    DriverActivityReport::Row.new(
      event.timestamp, event.timestamp, event.activity
    )
  end
end
