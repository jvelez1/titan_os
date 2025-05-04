class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :handle_missing_param
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def handle_missing_param(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  def record_not_found(error)
    render json: { error: "Record not found" }, status: :not_found
  end
end
