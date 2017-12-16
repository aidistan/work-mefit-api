require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  setup do
    @user = roles(:user)
  end

  test_fixtures

  test 'name should be uniq' do
    role = Role.new(name: @user.name)
    assert_not role.valid?
    assert_includes role.errors.details[:name], error: :taken, value: @user.name
  end

  test 'name should be presence' do
    role = Role.new(name: '')
    assert_not role.valid?
    assert_includes role.errors.details[:name], error: :blank
  end
end
