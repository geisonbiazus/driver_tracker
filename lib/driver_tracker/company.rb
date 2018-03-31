module DriverTracker
  class Company
    attr_accessor :id, :field

    def initialize(id: nil, field: nil)
      self.id = id
      self.field = field
    end

    def ==(other)
      id == other.id && field == other.field
    end
  end
end
