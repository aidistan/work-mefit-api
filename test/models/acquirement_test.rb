require 'test_helper'

class AcquirementTest < ActiveSupport::TestCase
  setup do
    @acquirement = acquirements(:aidi)
  end

  test_fixtures

  test 'should check calories' do
    @acquirement.calories = -1
    assert_not @acquirement.valid?
  end

  test 'should check fat' do
    @acquirement.fat = -1
    assert_not @acquirement.valid?
  end

  test 'should check protein' do
    @acquirement.protein = -1
    assert_not @acquirement.valid?
  end

  test 'should check carbohydrate' do
    @acquirement.carbohydrate = -1
    assert_not @acquirement.valid?
  end
end
