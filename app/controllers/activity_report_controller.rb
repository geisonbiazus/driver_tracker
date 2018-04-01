class ActivityReportController < ApplicationController
  def index
    return render status: :bad_request if driver_id.zero? || !date

    @report = DriverTracker.generate_report_interactor.run(driver_id, date)
    render status: :ok
  end

  private

  def driver_id
    report_params[:driver_id].to_i
  end

  def date
    Date.parse(report_params[:date])
  rescue TypeError, ArgumentError
    nil
  end

  def report_params
    params.permit(:driver_id, :date)
  end
end
