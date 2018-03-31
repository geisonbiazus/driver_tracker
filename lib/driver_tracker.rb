require 'date'
require 'ostruct'
require 'time'
require 'geokit'

require_relative 'driver_tracker/polygon'
require_relative 'driver_tracker/company'
require_relative 'driver_tracker/company_interactor'
require_relative 'driver_tracker/repositories/company_repository'
require_relative 'driver_tracker/repositories/event_repository'
require_relative 'driver_tracker/activity/event'
require_relative 'driver_tracker/activity/report'
require_relative 'driver_tracker/activity/generate_report_interactor'
require_relative 'driver_tracker/activity/add_event_interactor'

module DriverTracker
  class << self
    attr_accessor :company_repository
    attr_accessor :event_repository

    def company_interactor
      CompanyInteractor.new(company_repository)
    end

    def add_event_interactor
      Activity::AddEventInteractor.new(company_repository, event_repository)
    end

    def generate_report_interactor
      Activity::GenerateReportInteractor.new(event_repository)
    end
  end

  self.company_repository = Repositories::CompanyRepository.new
  self.event_repository = Repositories::EventRepository.new
end
