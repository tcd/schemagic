module Schemagic
  # Configuration for Schemagic.
  class Config

    # @return [String<"test", "development", "production">] ("development")
    attr_accessor :env
    # @return [String] Path to folder where generated files will be written.
    attr_accessor :data_folder

    # @return [void]
    def initialize()
      self.env = "development"
      # self.data_folder = File.join(Schemagic::Utility.get_working_dir, "schema")
      self.data_folder = nil
    end

  end
end
