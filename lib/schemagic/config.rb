module Schemagic
  # Configuration for Schemagic.
  class Config

    # @return [String<"test", "development", "production">] The current application environment.
    attr_accessor :env
    # @return [String,Pathname] Path to folder where generated files will be written.
    attr_accessor :data_folder
    # @return [String] Url for reference schemas.
    attr_accessor :schema_url

    # @return [void]
    def initialize()
      if defined?(Rails)
        self.env = Rails.env
        self.data_folder = Rails.root.join("app", "schema")
        self.data_folder = ""
      else
        self.env = "development"
        self.data_folder = nil
        # self.data_folder = File.join(Dir.pwd(), "tmp", "schemagic", "schema")
        self.data_folder = File.join(Dir.pwd(), "app", "schema")
        self.schema_url = ""
        # self.schema_url = "https://raw.githubusercontent.com/[USERNAME]/[REPO]/master/path/to/schema/folder"
      end
    end

    # @return [Pathname]
    def data_folder_path()
      if self.data_folder.blank?()
        if defined?(Rails)
          self.data_folder = Rails.root.join("app", "schema")
        else
          raise ::StandardError.new("Schemagic.config.data_folder is blank")
        end
      end
      return self.data_folder if self.data_folder.is_a?(Pathname)
      return Pathname.new(self.data_folder)
    end

  end
end
