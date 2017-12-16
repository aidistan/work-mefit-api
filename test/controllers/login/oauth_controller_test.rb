require 'test_helper'

class Login::OauthControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:aidi)
    @client = clients(:web)
  end

  test 'should render authorize with right params' do
    get login_oauth_authorize_url(
      response_type: 'code',
      client_id: @client.uuid,
      redirect_uri: @client.redirect_uri
    )
    assert_response :success
  end

  test 'should reject authorize with wrong params' do
    get login_oauth_authorize_url(client_id: @client.uuid, redirect_uri: @client.redirect_uri)
    assert_response :bad_request
    get login_oauth_authorize_url(response_type: 'code', client_id: @client.uuid)
    assert_response :bad_request
  end

  test 'should support implicit flow' do
    post login_oauth_authorize_url, params: {
      response_type: 'access',
      client_id: @client.uuid,
      redirect_uri: @client.redirect_uri,
      credentials: { mobile: @user.mobile, password: 'Pa55word' }
    }
    assert_response :redirect
    assert_redirected_to Regexp.new(@client.redirect_uri)
    assert CGI.parse(URI(response.headers['Location']).query)['access_token']
  end

  test 'should support authorization code flow' do
    post login_oauth_authorize_url, params: {
      response_type: 'code',
      client_id: @client.uuid,
      redirect_uri: @client.redirect_uri,
      credentials: { mobile: @user.mobile, password: 'Pa55word' }
    }
    assert_response :redirect
    assert_redirected_to Regexp.new(@client.redirect_uri)
    assert code = CGI.parse(URI(response.headers['Location']).query)['code']

    post login_oauth_access_token_url, as: :json, params: {
      client_id: @client.uuid,
      client_secret: @client.secret,
      code: code
    }
    assert_response :success
    assert JSON.parse(response.body)['access_token']
  end

  test 'should reject access_token with exipred code_token' do
    post login_oauth_authorize_url, params: {
      response_type: 'code',
      client_id: @client.uuid,
      redirect_uri: @client.redirect_uri,
      credentials: { mobile: @user.mobile, password: 'Pa55word' }
    }
    code = CGI.parse(URI(response.headers['Location']).query)['code']

    travel 601.seconds # wait for more than 10 minutes

    post login_oauth_access_token_url, as: :json, params: {
      client_id: @client.uuid,
      client_secret: @client.secret,
      code: code
    }
    assert_response :unauthorized
  end
end
