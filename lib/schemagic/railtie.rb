module Schemagic
  class Railtie < ::Rails::Railtie
    generators do
      require "generators/schemagic/init/init_generator"
    end
  end
end
