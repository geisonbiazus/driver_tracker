module DriverTracker
  class CompanyInteractor
    INVALID = 'INVALID'.freeze

    def initialize(company_repository)
      @company_repository = company_repository
    end

    def create(field:)
      errors = validate_polygon(field)

      return error_response(errors) unless errors.empty?

      company = Company.new(field: field)
      success_response(@company_repository.create(company))
    end

    private

    def validate_polygon(field)
      errors = []
      unless valid_polygon?(field)
        errors << { field: :field, type: INVALID }
      end
      errors
    end

    def valid_polygon?(polygon)
      return false unless polygon.is_a?(Array)
      polygon.each do |point|
        return false unless point.is_a?(Array)
        return false unless point.size == 2
        point.each do |axis|
          return false unless axis.is_a?(Numeric)
        end
      end
      true
    end

    def error_response(errors)
      { status: :error, errors: errors }
    end

    def success_response(company)
      { status: :success, company: company }
    end
  end
end
