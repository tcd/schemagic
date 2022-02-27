module Schemagic
  class Railtie < ::Rails::Railtie

    rake_tasks do
      rake_tasks do
        # load "tasks/production/yard_tasks.rake"
        # load "tasks/production/schemagic_tasks.rake"
        Dir["tasks/production/*.rake"].each { |rake| load rake }
      end
    end

    generators do
      require "generators/schemagic/initializer/initializer_generator"
    end

    # initializer "schemagic.configure_rails_initialization" do
    #   # some initialization behavior
    # end

  end
end
