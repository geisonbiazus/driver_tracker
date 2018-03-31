module DriverTracker
  module Activity
    class Event
      CULTIVATING = 'cultivating'.freeze
      REPAIRING = 'repairing'.freeze
      DRIVING = 'driving'.freeze
      STOPPED = 'stopped'.freeze

      attr_accessor :company_id, :driver_id, :timestamp, :latitude,
                    :longitude, :accuracy, :speed, :activity

      def initialize(company_id: nil,
                     driver_id: nil,
                     timestamp: nil,
                     latitude: nil,
                     longitude: nil,
                     accuracy: nil,
                     speed: nil,
                     activity: nil)
        self.company_id = company_id
        self.driver_id = driver_id
        self.timestamp = timestamp
        self.latitude = latitude
        self.longitude = longitude
        self.accuracy = accuracy
        self.speed = speed
        self.activity = activity
      end

      def ==(other)
        company_id == other.company_id &&
          driver_id == other.driver_id &&
          timestamp == other.timestamp &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          accuracy == other.accuracy &&
          speed == other.speed &&
          activity == other.activity
      end
    end
  end
end
