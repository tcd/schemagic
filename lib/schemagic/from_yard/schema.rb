module Schemagic
  module FromYard
    # Reference:
    #
    # - [Generic keywords](https://json-schema.org/understanding-json-schema/reference/generic.html)
    # - [Schema Composition](https://json-schema.org/understanding-json-schema/reference/combining.html)
    # - [JSON Schema - deprecated](http://json-schema.org/draft/2019-09/json-schema-validation.html#rfc.section.9.3)
    class Schema

      # @return [YARD::Registry]
      attr_accessor(:registry)

      # @return [String] Ruby class name
      attr_accessor(:name)

      # @return [YARD::CodeObjects::ClassObject] YARD data about the class
      attr_accessor(:code_object)

      # @return [String]
      attr_accessor(:id)

      # @return [String]
      attr_accessor(:schema)

      # @return [String]
      attr_accessor(:kind)

      # @return [String]
      attr_accessor(:title)

      # @return [String]
      attr_accessor(:type)

      # @return [String]
      attr_accessor(:description)

      # @return [Boolean]
      attr_accessor(:additional_properties)

      # @return [Array<String>]
      attr_accessor(:required_properties)

      # @return [Hash]
      attr_accessor(:properties)

      # @param registry [YARD::Registry]
      # @param name [String]
      #
      # @return [void]
      def initialize(registry, name)
        self.registry    = registry
        self.name        = name
        self.code_object = registry.at(name)

        self.properties            = {}
        self.required_properties   = []

        self.schema                = "http://json-schema.org/draft-07/schema#"
        self.type                  = "object"
        self.additional_properties = false

        self.id          = "https://combo-notebook.dunston.io/api/v2/schema/#{name.gsub('::', '').underscore.dasherize}.json"
        self.kind        = self.name.gsub("::", "")
        self.title       = self.name.gsub("::", "").titleize
        self.description = self.code_object&.docstring unless self.code_object&.docstring.blank?()
      end

      # @return [Hash]
      def to_h()
        data = {}

        data["$id"]                  = self.id
        data["$schema"]              = self.schema
        data["title"]                = self.title
        data["type"]                 = self.type

        unless self.description.blank?
          data["description"] = self.description
        end

        data["additionalProperties"] = self.additional_properties

        unless self.required_properties.blank?()
          data["required"] = self.required_properties
        end

        data["properties"] = self.properties

        return data
      end

      # @return [Boolean]
      def is_valid?()
        if self.code_object&.meths.blank?
          puts("Model with no attributes: ", self.title)
          return false
        end
        return true
      end

      # @return [void]
      def set_kind_property()
        self.properties["kind"] = {
          readOnly: true,
          const: self.kind,
        }
      end

      # @return [void]
      def parse_attributes()
        self.set_kind_property()
        self.code_object
            .meths
            .filter { |meth| meth.group == "Attributes" }
            .reject { |a| a.name.to_s =~ /\=\Z/ }
            .each { |a| self.parse_attribute(a) }
      end

      # @param a [Object]
      #
      # @return [void]
      def parse_attribute(a)
        attribute = Attribute.new(self.code_object, a)

        if attribute.is_required
          self.required_properties << attribute.name
        end

        self.properties[attribute.name] = attribute.custom_to_h()
      end

    end
  end
end
