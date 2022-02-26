module Schemagic
  class Railtie < ::Rails::Railtie
    generators do
      require "generators/schemagic/initializer/initializer_generator"
    end
  end
end
