require "schemagic/from_yard/helpers"
require "schemagic/from_yard/attribute"
require "schemagic/from_yard/schema"
require "schemagic/from_yard/generator"

module Schemagic
  # Pull data from YARD docs.
  module FromYard

    # @return [void]
    def self.generate()
      Generator.generate()
    end

  end
end
