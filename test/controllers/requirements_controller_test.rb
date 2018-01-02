require 'test_helper'

class RequirementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:aidi)
    @token = tokens(:aidi).uuid
    @requirement = requirements(:aidi)

    @other_user = users(:user)
    @other_token = tokens(:user).uuid
  end

  def requirement_params
    {
      formula: @requirement.formula,
      calories: @requirement.calories,
      fat: @requirement.fat,
      protein: @requirement.protein,
      carbohydrate: @requirement.carbohydrate,
      measurement_id: @requirement.measurement_id
    }
  end

  test 'should get index' do
    get user_requirements_url(@user, access_token: @token), as: :json
    assert_response :success
    assert_not_empty JSON.parse(response.body)

    get user_requirements_url(@user, access_token: @other_token), as: :json
    assert_response :success
    assert_empty JSON.parse(response.body)
  end

  test 'should create requirement' do
    assert_difference('Requirement.count', 1) do
      post user_requirements_url(@user, access_token: @token),
        params: { requirement: requirement_params }, as: :json
    end
    assert_response :created

    assert_no_difference('Requirement.count') do
      post user_requirements_url(@user, access_token: @other_token),
        params: { requirement: requirement_params }, as: :json
    end
    assert_response :unauthorized
  end

  test 'should show requirement' do
    get requirement_url(@requirement, access_token: @token), as: :json
    assert_response :success
    assert_equal JSON.parse(response.body)['user_id'], @user.id

    get requirement_url(@requirement, access_token: @other_token), as: :json
    assert_response :unauthorized
  end

  test 'should update requirement' do
    put requirement_url(@requirement, access_token: @token),
      params: { requirement: { formula: 'custom' } }, as: :json
    assert_response :success
    assert_equal JSON.parse(response.body)['formula'], 'custom'

    put requirement_url(@requirement, access_token: @other_token),
      params: { requirement: { gender: 'female' } }, as: :json
    assert_response :unauthorized
  end

  test 'should destroy requirement' do
    assert_no_difference('Requirement.count') do
      delete requirement_url(@requirement, access_token: @other_token), as: :json
    end
    assert_response :unauthorized

    assert_difference('Requirement.count', -1) do
      delete requirement_url(@requirement, access_token: @token), as: :json
    end
    assert_response :no_content
  end
end
