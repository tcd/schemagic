require "test_helper"

module Tests
  module Models
    class UserTest < ActiveSupport::TestCase

      setup do
        @model         = User
        @initial_count = @model.count()
      end

      test "that there are fixtures" do
        assert(@initial_count > 0)
      end

      test "#display_name" do
        entity = @model.first()
        refute_nil(entity.display_name)
      end

    end
  end
end
