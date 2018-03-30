class DriverActivityReport
  attr_accessor :driver_id, :date, :rows

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
  end
end
