class ActivityReportController < ApplicationController
  def index
    @report = DriverTracker.generate_report_interactor.run(driver_id, date)
  end

  private

  def driver_id
    report_params[:driver_id].to_i
  end

  def date
    report_params[:date].to_date
  end

  def report_params
    params.permit(:driver_id, :date)
  end
end
