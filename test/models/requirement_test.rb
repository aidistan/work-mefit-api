require 'test_helper'

class RequirementTest < ActiveSupport::TestCase
  setup do
    @requirement = requirements(:aidi)
  end

  test_fixtures

  test 'should check formula' do
    @requirement.formula = '   '
    assert_not @requirement.valid?
  end

  test 'should check calories' do
    @requirement.calories = -1
    assert_not @requirement.valid?
  end

  test 'should check fat' do
    @requirement.fat = -1
    assert_not @requirement.valid?
  end

  test 'should check protein' do
    @requirement.protein = -1
    assert_not @requirement.valid?
  end

  test 'should check carbohydrate' do
    @requirement.carbohydrate = -1
    assert_not @requirement.valid?
  end
end
