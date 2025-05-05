class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :handle_missing_param
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ArgumentError, with: :argument_error

  private

  def handle_missing_param(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  def record_not_found(error)
    render json: { error: "Record not found" }, status: :not_found
  end

  def record_invalid(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end

  def argument_error(error)
    render json: { error: error.message }, status: :bad_request
  end
end
