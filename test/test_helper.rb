require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase # rubocop:disable Style/ClassAndModuleChildren
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Test generator for fixtures
  def self.test_fixtures
    model = to_s.sub(/Test$/, '').constantize

    test 'fixtures should be valid' do
      model.all.each { |record| assert record.valid? }
    end
  end
end
