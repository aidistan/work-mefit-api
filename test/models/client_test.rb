require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  setup do
    @client = clients(:web)
  end

  test_fixtures

  test 'codename should be present' do
    @client.codename = ' '
    assert_not @client.valid?
  end

  test 'codename should be short' do
    @client.codename = 'a' * 65
    assert_not @client.valid?
  end

  test 'redirect_uri allowed to be nil' do
    @client.redirect_uri = nil
    assert @client.valid?
  end

  test 'redirect_uri should be present' do
    @client.redirect_uri = ' '
    assert_not @client.valid?
  end

  test 'redirect_uri should be valid' do
    @client.redirect_uri = '0://'
    assert_not @client.valid?
  end

  test 'redirect_uri should has no query' do
    @client.redirect_uri = 'http://www.example.com?query'
    assert_not @client.valid?
  end
end
