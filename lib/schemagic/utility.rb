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

  end
end
