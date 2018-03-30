class TrackingEvent
  attr_accessor :timestamp, :activity

  def initialize(timestamp:, activity:)
    self.timestamp = timestamp
    self.activity = activity
  end
end
