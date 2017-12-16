require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:aidi)
    @access_token = @user.tokens.where(kind: 'access').first.uuid
  end

  test 'should show user' do
    get user_url(@user, access_token: @access_token), as: :json
    assert_response :success
  end

  test 'should update user' do
    put user_url(@user, access_token: @access_token), params: {
      user: { gender: 0 }
    }, as: :json
    assert_response :success
  end
end
