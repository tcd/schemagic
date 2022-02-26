require "schemagic/from_yard/attribute"
require "schemagic/from_yard/schema"
require "schemagic/from_yard/v3"

module Schemagic
  # Pull data from YARD docs.
  module FromYard

    # @return [void]
    def self.generate()
      V3.generate()
    end

  end
end
