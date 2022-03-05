module Dummy2
  class Application < Rails::Application

    # @return [String]
    VERSION = "1.0.0".freeze()

    # @return [String]
    def version()
      return VERSION
    end

  end
end
