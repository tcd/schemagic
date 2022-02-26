module Schemagic
  module FromYard
    module Legacy
      class V2

        # FIXME: Handle Arrays and types defined with brackets & braces
        #
        # See the [JSON Schema](https://json-schema.org/understanding-json-schema/reference/string.html)
        #
        # @return [Hash{String => String}]
        def self.type_map()
          return {
            "Array"      => "array",
            "Hash"       => "object",
            "nil"        => "null",
            "Boolean"    => "boolean",
            "String"     => "string",
            "Integer"    => "number",
            "Decimal"    => "number",
            "Numeric"    => "number",
            "BigDecimal" => "number",
            "Date"       => "string", # format: date
            "Time"       => "string", # format: time
            "DateTime"   => "string", # format: date-time
          }
        end

        # See the [JSON Schema](https://json-schema.org/understanding-json-schema/reference/string.html#id7)
        #
        # @return [Hash{String => String}]
        def self.time_format_map()
          return {
            "Date"     => "time",
            "Time"     => "time",
            "DateTime" => "date-time",
          }
        end

        # @return [void]
        def self.generate()
          Rails.application.eager_load!
          yard_path = Rails.root.join(".yardoc").to_s
          registry  = YARD::Registry.load(yard_path)
          ApplicationRecord.descendants.map(&:to_s).each do |name|
            parse_descendant(registry, name)
          end
          return nil
        end

        # @return [void]
        def self.parse_descendant(registry, name)
          timestamp_note = "An ISO 8601 DateTime value"
          code_object = registry.at(name)
          required_properties = []
          data = {}
          data["$id"]                  = "https://combo-notebook.dunston.io/api/v2/schema/#{name.gsub('::', '').underscore.dasherize}.schema.json"
          data["$schema"]              = "http://json-schema.org/draft-07/schema#"
          data["title"]                = name.gsub("::", "")
          data["type"]                 = "object"
          data["description"]          = code_object&.docstring unless code_object&.docstring.blank?
          data["additionalProperties"] = false
          properties = {}

          if code_object&.meths.blank?
            puts("Model with no attributes: ", data["title"])
            return
          end

          attributes = code_object.meths
                                  .filter { |meth| meth.group == "Attributes" }
                                  .reject { |a| a.name.to_s =~ /\=\Z/ }
          attributes.each do |a|
            a&.tags&.filter{ |x| x.tag_name == "required" }.each{ |x| required_properties << x.object.name }
            ruby_type       = a.tags.find { |t| t.tag_name == "return" }.types&.first
            doc             = a.docstring.to_s
            type            = {}
            outer_ruby_type = ruby_type.split(/[<{]/).first
            type["type"]        = self.type_map[outer_ruby_type] || outer_ruby_type
            type["description"] = doc unless doc.blank?
            if (fmt = self.time_format_map[ruby_type])
              type["format"]      = fmt
              type["description"] = doc.blank? ? timestamp_note : "#{doc} (#{timestamp_note})".strip
            end
            properties[a.name.to_s] = type
          end

          unless required_properties.blank?()
            data["required"] = required_properties
          end

          data["properties"] = properties

          puts(Schemagic::Utility.save_to_file(JSON.pretty_generate(data), "schema/#{name.underscore}.json"))

        end

      end
    end
  end
end
