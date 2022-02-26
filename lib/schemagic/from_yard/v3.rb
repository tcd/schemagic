module Schemagic
  module FromYard
    class V3

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
        Rails.application.eager_load!()
        yard_path = Rails.root.join(".yardoc").to_s()
        registry  = YARD::Registry.load(yard_path)
        models = [
          *ApplicationRecord.descendants,
        ]
        models.map(&:to_s).each do |name|
          descendant = Schema.new(registry, name)
          if descendant.is_valid?
            descendant.parse_attributes()
            puts(Lib::Util.save_to_file(JSON.pretty_generate(descendant.to_h), "schema/#{name.underscore}.json", add_timestamp: false))
          end
        end
        return nil
      end

      # @return [void]
      def self.generate_json_models()
        Rails.application.eager_load!()
        yard_path = Rails.root.join(".yardoc").to_s
        registry  = YARD::Registry.load(yard_path)
        Models::Json::JsonRecord.descendants.map(&:to_s).each do |name|
          descendant = Schema.new(registry, name)
          if descendant.is_valid?
            descendant.parse_attributes()
            puts(Lib::Util.save_to_file(JSON.pretty_generate(descendant.to_h), "schema/json/#{name.underscore}.json"))
          end
        end
        return nil
      end

      # @return [void]
      def self.debug()
        Rails.application.eager_load!()
        yard_path = Rails.root.join(".yardoc").to_s
        registry  = YARD::Registry.load(yard_path)
        binding.pry
        return nil
      end

    end
  end
end
