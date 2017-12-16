class Login::OauthController < ApplicationController
  skip_before_action :authenticate_access_token
  before_action :set_client

  def authorize
    return head :bad_request unless @client.redirect_uri == params[:redirect_uri] &&
                                    %w[code access].include?(params[:response_type])
    if request.get?
      render layout: 'layouts/application'
    elsif create_token_with_credentials
      redirect_to build_redirect_url
    else
      @flash = 'Credentials failed'
      render layout: 'layouts/application'
    end
  end

  def access_token
    return head :bad_request unless @client.secret == params[:client_secret]

    token = Token.find_by(uuid: params[:code], kind: 'code', client: @client)
    if token && !token.expired?
      token.destroy
      render json: Token.create(client: @client, user: token.user).to_access_token
    else
      head :unauthorized
    end
  end

  private

  def set_client
    @client = Client.find_by(uuid: params[:client_id])
    head :bad_request unless @client
  end

  def create_token_with_credentials
    user = User.find_by(mobile: params[:credentials][:mobile])
    if user && user.authenticate(params[:credentials][:password])
      @token =
        if params[:response_type] == 'code'
          user.tokens.create(client: @client, kind: 'code', expires_in: 10.minutes)
        else
          user.tokens.create(client: @client)
        end
    end
  end

  def build_redirect_url
    @client.redirect_uri + '?' +
      (params[:state] ? "state=#{params[:state]}&" : '') +
      if params[:response_type] == 'code'
        "code=#{@token.uuid}"
      else
        @token.to_access_token.map { |k, v| "#{k}=#{v}" }.join('&')
      end
  end
end
