require "test_helper"

module Tests
  class SchemagicTest < ActiveSupport::TestCase

    test "it has a version number" do
      assert(Schemagic::VERSION)
    end

  end
end
