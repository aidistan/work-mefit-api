require 'test_helper'

class TokenTest < ActiveSupport::TestCase
  setup do
    @user = users(:aidi)
    @client = clients(:web)
  end

  test 'could check expiration' do
    token = Token.create(user: @user, client: @client, expires_in: -1)
    assert token.expired?
    assert_raises(ActiveRecord::RecordNotFound) { token.reload }
  end
end
