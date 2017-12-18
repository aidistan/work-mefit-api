require 'test_helper'

class MeasurementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:aidi)
    @token = tokens(:aidi).uuid
    @measurement = measurements(:aidi)

    @other_user = users(:user)
    @other_token = tokens(:user).uuid
  end

  def measurement_params
    {
      gender: @measurement.gender,
      age: @measurement.age,
      height: @measurement.height,
      weight: @measurement.weight,
      activity_level: @measurement.activity_level
    }
  end

  test 'should get index' do
    get user_measurements_url(@user, access_token: @token), as: :json
    assert_response :success
    assert_not_empty JSON.parse(response.body)

    get user_measurements_url(@user, access_token: @other_token), as: :json
    assert_response :success
    assert_empty JSON.parse(response.body)
  end

  test 'should create measurement' do
    assert_difference('Measurement.count', 1) do
      post user_measurements_url(@user, access_token: @token),
        params: { measurement: measurement_params }, as: :json
    end
    assert_response :created

    assert_no_difference('Measurement.count') do
      post user_measurements_url(@user, access_token: @other_token),
        params: { measurement: measurement_params }, as: :json
    end
    assert_response :unauthorized
  end

  test 'should show measurement' do
    get measurement_url(@measurement, access_token: @token), as: :json
    assert_response :success
    assert_equal JSON.parse(response.body)['user_id'], @user.id

    get measurement_url(@measurement, access_token: @other_token), as: :json
    assert_response :unauthorized
  end

  test 'should update measurement' do
    put measurement_url(@measurement, access_token: @token),
      params: { measurement: { gender: 'female' } }, as: :json
    assert_response :success
    assert_equal JSON.parse(response.body)['gender'], 'female'

    put measurement_url(@measurement, access_token: @other_token),
      params: { measurement: { gender: 'female' } }, as: :json
    assert_response :unauthorized
  end

  test 'should destroy measurement' do
    assert_no_difference('Measurement.count') do
      delete measurement_url(@measurement, access_token: @other_token), as: :json
    end
    assert_response :unauthorized

    assert_difference('Measurement.count', -1) do
      delete measurement_url(@measurement, access_token: @token), as: :json
    end
    assert_response :no_content
  end
end
