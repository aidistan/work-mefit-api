class ApplicationController < ActionController::API
  # Include for authorization
  include Pundit

  attr_reader :current_user, :current_token

  before_action :authenticate_access_token
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  rescue_from(Pundit::NotAuthorizedError) { head :unauthorized }
  # rescue_from(ActiveRecord::DeleteRestrictionError) { head :precondition_required }

  private

  # Authenticate access_token in the request
  def authenticate_access_token
    token = Token.includes(user: :roles).find_by(
      uuid: request.headers['Authorization'] || params[:access_token],
      kind: 'access'
    )

    if token && !token.expired?
      @current_user = token.user
      @current_token = token

      token.update_columns(last_used_at: Time.now, last_used_ip: request.remote_ip)
    else
      head :unauthorized
    end
  end
end
