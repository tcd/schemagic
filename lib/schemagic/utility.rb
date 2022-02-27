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

    # @return [void]
    def self.load_models()
      Dir[Rails.root.join("app/models/**/*.rb")].each { |model| require_relative model }
    rescue NameError => _e
      return nil
    end

    # @return [Pathname]
    def self.yard_db_folder()
      return Rails.root.join("tmp", "schemagic", ".yardoc").to_s()
    rescue NameError => _e
      return nil
    end

  end
end
