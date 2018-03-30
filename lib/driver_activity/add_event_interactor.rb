module DriverActivity
  class AddEventInteractor
    PAYLOAD_FIELDS = %i[company_id driver_id timestamp latitude longitude accuracy speed].freeze
    REQUIRED = 'REQUIRED'.freeze

    def initialize(company_repository, event_repository)
      @company_repository = company_repository
      @event_repository = event_repository
    end

    def run(payload)
      errors = validate_payload(payload)
      return error_response(errors) unless errors.empty?
      process_event(payload)
      success_response
    end

    private

    def validate_payload(payload)
      errors = []
      PAYLOAD_FIELDS.each do |field|
        errors << { field: field, type: REQUIRED } if payload[field].nil?
      end
      errors
    end

    def process_event(payload)
      event = Event.new(payload)
      event.activity = resolve_event_activity(event)
      @event_repository.create(event)
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

    def error_response(errors)
      { status: :error, errors: errors }
    end

    def success_response
      { status: :success }
    end
  end
end
