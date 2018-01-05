require 'test_helper'

class RequirementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:aidi)
    @token = tokens(:aidi).uuid
    @requirement = requirements(:aidi)
  end

  test 'should get index' do
    get user_requirements_url(@user, access_token: @token), as: :json
    assert_response :success
    assert_not_empty JSON.parse(response.body)
  end

  test 'should create requirement' do
    assert_difference('Requirement.count', 1) do
      post user_requirements_url(@user, access_token: @token),
        params: { requirement: @requirement }, as: :json
    end
    assert_response :created
  end

  test 'should show requirement' do
    get requirement_url(@requirement, access_token: @token), as: :json
    assert_response :success
    assert_equal JSON.parse(response.body)['user_id'], @user.id
  end

  test 'should update requirement' do
    put requirement_url(@requirement, access_token: @token),
      params: { requirement: { formula: 'custom' } }, as: :json
    assert_response :success
    assert_equal JSON.parse(response.body)['formula'], 'custom'
  end

  test 'should destroy requirement' do
    assert_difference('Requirement.count', -1) do
      delete requirement_url(@requirement, access_token: @token), as: :json
    end
    assert_response :no_content
  end
end
