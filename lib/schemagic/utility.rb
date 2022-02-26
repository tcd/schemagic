module Schemagic
  # Helper methods
  module Utility

    # @param code_object [YARD::CodeObjects::Base]
    # @param tag_name [String]
    # @return [Yard::Tags::Tag]
    def self.find_tag(code_object, tag_name)
      return code_object&.tags&.find { |x| x.tag_name == tag_name } || nil
    end

    # @param code_object [YARD::CodeObjects::Base]
    # @param tag_name [String]
    # @return [Array<Yard::Tags::Tag>]
    def self.find_tags(code_object, tag_name)
      return code_object&.tags&.filter { |x| x.tag_name == tag_name } || nil
    end

    # Write out data to a JSON file in `ActiveStorage::Blob` for the current `Rails.env`.
    # Prepends a unique timestamp to the filename.
    #
    # @param data [Object]
    # @param name [String]
    # @return [String]
    def self.save_to_file(data, name, add_timestamp: true)
      base_name = File.basename(name)
      file_name = base_name
      if add_timestamp
        file_name = "#{Time.zone.now.to_i}.#{base_name}"
      end
      name.gsub!(base_name, file_name)
      path = Rails.root.join("storage", "saved_files", name)
      FileUtils.mkdir_p(path.parent)
      data = JSON.pretty_generate(data) unless data.is_a?(String)
      File.open(path, "a") { |f| f.write(data) }
      # File.write(path, data, mode: "a")
      return path.to_s()
    end

    # @return [void]
    def self.load_models()
      Dir[Rails.root.join("app/models/**/*.rb")].each { |model| require_relative model }
    end

    # @return [Pathname]
    def self.yard_db_folder()
      return Rails.root.join("tmp", "schemagic", ".yardoc").to_s()
    end

  end
end
