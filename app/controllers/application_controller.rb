class ApplicationController < ActionController::API
  before_action :authenticate_access_token

  private

  # Authenticate access_token in the request
  def authenticate_access_token
    token = Token.find_by(
      uuid: headers['Authorization'] || params[:access_token],
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
