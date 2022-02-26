module Schemagic
  class Railtie < ::Rails::Railtie

    rake_tasks do
      load "tasks/schemagic_tasks.rake"
    end

    generators do
      require "generators/schemagic/initializer/initializer_generator"
    end

    initializer "schemagic.configure_rails_initialization" do |app|
      binding.pry
    end

  end
end
