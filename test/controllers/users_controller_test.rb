require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:aidi)
  end

  test 'should show user' do
    get user_url(@user), as: :json
    assert_response :success
  end

  test 'should update user' do
    put user_url(@user), params: { user: { gender: 0 } }, as: :json
    assert_response 200
  end
end
