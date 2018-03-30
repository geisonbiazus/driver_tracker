module DriverActivity
  class AddEventInteractor
    def initialize(event_repository)
      @event_repository = event_repository
    end

    def run(payload)
      event = Event.new(event_attributes(payload))
      assigin_event_activity(event)
      @event_repository.create(event)
    end

    private

    def event_attributes(payload)
      payload.merge(
        timestamp: Time.parse(payload[:timestamp]),
      )
    end

    def assigin_event_activity(event)
      if event.speed >= 1
        event.activity = Event::CULTIVATING
      else
        event.activity = Event::REPAIRING
      end
    end
  end
end
