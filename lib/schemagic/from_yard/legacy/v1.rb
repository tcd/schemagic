module Schemagic
  module FromYard
    module Legacy
      # This was the original version.
      # It doesn't quite get to JSON schema, but it's very clean and I'm proud of it.
      class V1

        # @return [void]
        def self.call()
          Rails.application.eager_load!
          model_name_paths = ApplicationRecord.descendants.map(&:to_s)
          yard_path = Rails.root.join(".yardoc").to_s()
          registry = YARD::Registry.load(yard_path)
          models = []
          model_name_paths.each do |name|
            code_object = registry.at(name)
            models << {
              name:       name,
              docstring:  code_object.docstring,
              properties: code_object.meths
                                      .map    { |meth| (meth.group == "Attributes") ? meth : nil }
                                      .compact
                                      .reject { |a| a.name.to_s =~ /\=\Z/ }
                                      .map    { |a| {
                                        name:      a.name.to_s,
                                        docstring: a.docstring,
                                        types:     a.tags.find { |t| t.tag_name == "return" }.types,
                                      }}
            }
          end
          puts(Schemagic::Utility.save_to_file(models.to_json, "models.json"))
        end

      end
    end
  end
end
