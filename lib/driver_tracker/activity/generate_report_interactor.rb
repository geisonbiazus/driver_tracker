module DriverTracker
  module Activity
    class GenerateReportInteractor
      def initialize(event_repository)
        @event_repository = event_repository
      end

      def run(driver_id, date)
        events = @event_repository
                 .find_all_by_driver_id_and_date_sorted_by_timestamp(
                   driver_id, date
                 )
        report = Report.new(driver_id, date)
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

        if !last
          report.rows << create_report_row(event)
        else
          last.to = event.timestamp
          if last.activity != event.activity
            report.rows << create_report_row(event)
          end
        end
      end

      def create_report_row(event)
        Report::Row.new(
          event.timestamp, event.timestamp, event.activity
        )
      end
    end
  end
end
