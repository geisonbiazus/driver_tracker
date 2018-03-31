class ActivityEventsController < ApplicationController
  def create
    AddActivityEventJob.perform_later(event_params.to_h)
    head :ok
  end

  private

  def event_params
    params.require(:activity_event).permit(
      :company_id, :driver_id, :timestamp,
      :latitude, :longitude, :accuracy, :speed
    )
  end
end
