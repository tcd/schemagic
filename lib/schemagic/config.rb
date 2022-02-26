module Schemagic
  # Configuration for Schemagic.
  class Config

    # @return [String<"test", "development", "production">] The current application environment.
    attr_accessor :env
    # @return [String] Path to folder where generated files will be written.
    attr_accessor :data_folder

    # @return [void]
    def initialize()
      if defined?(Rails)
        self.env = Rails.env
        self.data_folder = Rails.root.join("app", "schema")
      else
        self.env = "development"
        self.data_folder = nil
        # self.data_folder = File.join(Dir.pwd(), "schema")
      end
    end

  end
end
