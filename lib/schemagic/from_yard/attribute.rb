module Schemagic
  module FromYard
    # Processes a single attribute belonging to a Model.
    class Attribute

      # @return [String]
      TIMESTAMP_NOTE = "An ISO 8601 DateTime value".freeze()

      # @return [Array<String>]
      READONLY_PROPERTIES = [
        "id",
        "display_name",
        "created_at",
        "updated_at",
      ].freeze()

      # @return [YARD::CodeObjects::ClassObject] YARD data about the class the method belongs to
      attr_accessor(:class_code_object)

      # @return [YARD::CodeObjects::MethodObject] YARD data about the property
      attr_accessor(:method_code_object)

      # @return [String] Ruby method name
      attr_accessor(:name)

      # @return [String]
      attr_accessor(:ruby_type)

      # @return [String]
      attr_accessor(:json_schema_type)

      # @return [String]
      attr_accessor(:description)

      # @return [Boolean]
      attr_accessor(:is_deprecated)

      # @return [Boolean]
      attr_accessor(:is_read_only)

      # @return [Boolean]
      attr_accessor(:is_required)

      # @return [Object]
      attr_accessor(:default_value)

      # @return [Array<Object>]
      attr_accessor(:examples)

      # @return [String]
      attr_accessor(:format)

      # @param class_code_object [YARD::CodeObjects::Base]
      # @param method_code_object [YARD::CodeObjects::Base]
      #
      # @return [void]
      def initialize(class_code_object, method_code_object)
        self.class_code_object  = class_code_object
        self.method_code_object = method_code_object

        self.examples      = []
        self.is_read_only  = false
        self.is_required   = false
        self.is_deprecated = false
        self.name          = self.method_code_object.name.to_s()
        self.description   = self.method_code_object&.docstring&.to_s()

        self.determine_type()
        self.determine_if_deprecated()
        self.determine_if_read_only()
        self.determine_if_required()
        self.determine_default_value()
        self.parse_examples()
      end

      # @return [Hash]
      def custom_to_h()
        data = {}

        if self.is_deprecated
          data["deprecated"] = true
        end

        if self.is_read_only
          data["readOnly"] = true
        end

        data["type"] = self.json_schema_type

        unless self.description.blank?()
          data["description"] = self.description
        end

        unless self.default_value.blank?()
          data["default"] = self.default_value
        end
        if self.default_value == false
          data["default"] = self.default_value
        end

        unless self.format.blank?()
          data["format"] = self.format
        end

        unless self.examples.blank?()
          data["examples"] = self.examples
        end

        return data
      end

      # @return [void]
      def parse_examples()
        if (example_values = self.find_tags("example_value"))
          example_values.each do |value|
            self.examples << value.text
          end
        end
      end

      # @return [void]
      def determine_if_required()
        if find_tag(self.method_code_object, "required")
          self.is_required = true
        end
      end

      # @return [void]
      def determine_if_deprecated()
        if find_tag(self.method_code_object, "deprecated")
          self.is_deprecated = true
        end
      end

      # @return [void]
      def determine_if_read_only()
        if READONLY_PROPERTIES.include?(self.name)
          self.is_read_only = true
          return
        end
        if self.class_code_object.attributes.dig(:instance, self.name, :write).nil?()
          self.is_read_only = true
        end
      end

      # @return [void]
      def determine_default_value()
        if (default = find_tag(self.method_code_object, "default_value"))
          case self.ruby_type
          when "String"  then self.default_value = default.text
          when "Integer" then self.default_value = default.text.to_i()
          when "Numeric" then self.default_value = default.text.to_i()
          when "Boolean" then self.default_value = (default.text.downcase == "true")
          end
        end
      end

      # @return [void]
      def determine_type()
        self.ruby_type = self.find_tag("return")&.types&.first()
        outer_ruby_type = self.ruby_type.split(/[<{]/).first()
        self.json_schema_type = V3.type_map[outer_ruby_type] || outer_ruby_type
        if (fmt = V3.time_format_map[self.ruby_type])
          self.format = fmt
          self.description = self.description.blank? ? TIMESTAMP_NOTE : "#{self.description} (#{TIMESTAMP_NOTE})".strip()
        end

      end

      # @return [Yard::Tags::Tag]
      def find_tag(tag_name)
        return Schemagic::Utility.find_tag(self.method_code_object, tag_name)
      end

      # @return [Array<Yard::Tags::Tag>]
      def find_tags(tag_name)
        return Schemagic::Utility.find_tags(self.method_code_object, tag_name)
      end

    end
  end
end
