require File.join(Rails.root, 'lib', 'driver_tracker')

DriverTracker.company_repository = CompanyRepository.new
DriverTracker.event_repository = ActivityEventRepository.new
