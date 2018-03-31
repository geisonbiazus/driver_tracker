class CompaniesController < ApplicationController
  def create
    response = DriverTracker.company_interactor.create(field: field_param)
    if response[:status] == :success
      render json: response, status: :created
    else
      render json: response, status: :unprocessable_entity
    end
  end

  private

  def field_param
    JSON.parse(company_params[:field])
  rescue JSON::ParserError
    nil
  end

  def company_params
    params.require(:company).permit(:field)
  end
end
