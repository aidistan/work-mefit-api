require 'test_helper'

class MeasurementTest < ActiveSupport::TestCase
  setup do
    @measurement = measurements(:aidi)
  end

  test_fixtures

  test 'should check gender' do
    @measurement.gender = nil
    assert_not @measurement.valid?
  end

  test 'should check age' do
    @measurement.age = -1
    assert_not @measurement.valid?
  end

  test 'should check height' do
    @measurement.height = -1
    assert_not @measurement.valid?
  end

  test 'should check weight' do
    @measurement.weight = -1
    assert_not @measurement.valid?
  end

  test 'should check activity_level' do
    @measurement.activity_level = -1
    assert_not @measurement.valid?
  end
end
