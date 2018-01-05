require 'test_helper'

class AcquirementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:aidi)
    @token = tokens(:aidi).uuid
    @acquirement = acquirements(:aidi)
  end

  test 'should get index' do
    get user_acquirements_url(@user, access_token: @token), as: :json
    assert_response :success
    assert_not_empty JSON.parse(response.body)
  end

  test 'should create acquirement' do
    assert_difference('Acquirement.count', 1) do
      post user_acquirements_url(@user, access_token: @token),
        params: { acquirement: @acquirement }, as: :json
    end
    assert_response :created
  end

  test 'should show acquirement' do
    get acquirement_url(@acquirement, access_token: @token), as: :json
    assert_response :success
    assert_equal JSON.parse(response.body)['user_id'], @user.id
  end

  test 'should update acquirement' do
    put acquirement_url(@acquirement, access_token: @token),
      params: { acquirement: { formula: 'custom' } }, as: :json
    assert_response :success
    assert_equal JSON.parse(response.body)['user_id'], @user.id
  end

  test 'should destroy acquirement' do
    assert_difference('Acquirement.count', -1) do
      delete acquirement_url(@acquirement, access_token: @token), as: :json
    end
    assert_response :no_content
  end
end
