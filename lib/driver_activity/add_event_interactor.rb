module DriverActivity
  class AddEventInteractor
    def initialize(event_repository)
      @event_repository = event_repository
    end

    def run(payload)
      event = Event.new(payload.merge(timestamp: Time.parse(payload[:timestamp])))
      @event_repository.create(event)
    end
  end
end
