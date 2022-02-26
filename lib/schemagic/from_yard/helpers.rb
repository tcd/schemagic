module Schemagic
  module FromYard
    # Helpers
    class Helpers

      # @return [String]
      TIMESTAMP_NOTE = "An ISO 8601 DateTime value".freeze()

      # @return [Array<String>]
      READONLY_PROPERTIES = [
        "id",
        "display_name",
        "created_at",
        "updated_at",
      ].freeze()

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

    end
  end
end
