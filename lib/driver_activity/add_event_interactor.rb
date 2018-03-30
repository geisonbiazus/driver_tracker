module DriverActivity
  class AddEventInteractor
    def initialize(company_repository, event_repository)
      @company_repository = company_repository
      @event_repository = event_repository
    end

    def run(payload)
      event = Event.new(event_attributes(payload))
      event.activity = resolve_event_activity(event)
      @event_repository.create(event)
    end

    private

    def event_attributes(payload)
      payload.merge(
        timestamp: Time.parse(payload[:timestamp]),
      )
    end

    def resolve_event_activity(event)
      if inside_company_field(event)
        return Event::CULTIVATING if event.speed >= 1
        Event::REPAIRING
      else
        return Event::DRIVING if event.speed >= 5
        Event::STOPPED
      end
    end

    def inside_company_field(event)
      company = @company_repository.find_by_id(event.company_id)
      Polygon.new(company.field).contains?([event.latitude, event.longitude])
    end
  end
end
