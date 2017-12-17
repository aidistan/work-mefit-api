require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:aidi)
    @token = @user.tokens.where(kind: 'access').first.uuid
    @other_user = users(:sunny)
    @other_token = @other_user.tokens.where(kind: 'access').first.uuid
  end

  test 'should show user when authorized' do
    get user_url(@user, access_token: @token), as: :json
    assert_response :success
  end

  test 'should not show user when unauthorized' do
    get user_url(@user, access_token: @other_token), as: :json
    assert_response :unauthorized
  end

  test 'should update user when authorized' do
    put user_url(@user, access_token: @token), params: {
      user: { gender: 0 }
    }, as: :json
    assert_response :success
  end

  test 'should not update user when unauthorized' do
    put user_url(@user, access_token: @other_token), params: {
      user: { gender: 0 }
    }, as: :json
    assert_response :unauthorized
  end
end
