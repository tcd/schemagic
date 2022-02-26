module Schemagic
  # Rails engine for Schemagic.
  class Engine < ::Rails::Engine
    isolate_namespace(Schemagic)
    # config.generators.api_only = true
  end
end
