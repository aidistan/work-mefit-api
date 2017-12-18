require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:aidi)
    @token = tokens(:aidi).uuid
    @other_user = users(:user)
    @other_token = tokens(:user).uuid
  end

  test 'should show user' do
    get user_url(@user, access_token: @token), as: :json
    assert_response :success

    get user_url(@user, access_token: @other_token), as: :json
    assert_response :unauthorized
  end

  test 'should update user' do
    put user_url(@user, access_token: @token),
      params: { user: { gender: 0 } }, as: :json
    assert_response :success

    put user_url(@user, access_token: @other_token),
      params: { user: { gender: 0 } }, as: :json
    assert_response :unauthorized
  end
end
