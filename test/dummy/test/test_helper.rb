ENV["RAILS_ENV"] ||= "test"

require_relative "../config/environment"
require "rails/test_help"

# @abstract
class ActiveSupport::TestCase

  # Run tests in parallel with specified workers.
  parallelize(workers: 1)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # Read about fixtures at https://api.rubyonrails.org/classes/ActiveRecord/FixtureSet.html
  fixtures(:all)

end
