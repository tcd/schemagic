module Schemagic
  module FromYard
    # Generate JSON schemas for Rails models.
    class Generator

      # @return [void]
      def self.generate()
        Schemagic::Utility.load_models()

        registry  = YARD::Registry.load(Schemagic::Utility.yard_db_folder())
        models    = [*ApplicationRecord.descendants]

        models.map(&:to_s).each do |name|
          descendant = Schema.new(registry, name)
          if descendant.is_valid?()
            descendant.parse_attributes()
            path = save_schema_to_file(descendant.to_h, name.underscore)
            puts("schema generated: '#{path}'")
          end
        end

        return nil
      end

      # @return [String]
      def self.save_schema_to_file(schema, name)
        data = JSON.pretty_generate(schema)
        file_name = "#{name}.json"
        path = Schemagic.config.data_folder_path.join(file_name)
        FileUtils.mkdir_p(path.parent)
        File.write(path, data, mode: "w+")
        return path
      end

    end
  end
end
