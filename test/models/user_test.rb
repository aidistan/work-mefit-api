require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:aidi)
  end

  test_fixtures

  test 'mobile should be uniq' do
    user = User.new(mobile: @user.mobile, password: 'Pa55word')
    assert_not user.valid?
    assert_includes user.errors.details[:mobile], error: :taken, value: @user.mobile
  end

  test 'mobile should be valid' do
    user = User.new(mobile: '11012345678', password: nil)
    assert_not user.valid?
    assert_includes user.errors.details[:mobile], error: :invalid
  end

  test 'nickname should be uniq' do
    user = User.new(mobile: '18812345678', password: 'Pa55word', nickname: @user.nickname)
    assert_not user.valid?
    assert_includes user.errors.details[:nickname], error: :taken, value: @user.nickname
  end

  test 'must have an identifier' do
    user = User.new(password: 'Pa55word')
    assert_not user.valid?
    assert_includes user.errors.details[:mobile], error: :blank
  end
end
