module DriverTracker
  module Activity
    class Report
      attr_accessor :driver_id, :date, :rows

      def initialize(driver_id, date)
        self.driver_id = driver_id
        self.date = date
        self.rows = []
      end

      class Row
        attr_accessor :from, :to, :activity

        def initialize(from, to, activity)
          self.from = from
          self.to = to
          self.activity = activity
        end

        def ==(other)
          from == other.from && to == other.to && activity == other.activity
        end

        def time
          to - from
        end
      end
    end
  end
end
