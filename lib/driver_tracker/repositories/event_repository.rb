module DriverTracker
  module Repositories
    # This repository is just a dummy to be used as interface by tests.
    # The real repository should be implemented by application following the
    # interface of this class
    class EventRepository
      def create(_event)
        raise 'Not implemented'
      end

      def find_all_by_driver_id_and_date_sorted_by_timestamp(_driver_id, _date)
        raise 'Not implemented'
      end
    end
  end
end
