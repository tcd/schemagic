module Schemagic
  # Code for programmatically invoking YARD.
  module YardHelpers

    # @return [void]
    def self.register_custom_tags()
      raise StandardError, "YARD is not defined" unless defined?(YARD)

      # Models
      YARD::Tags::Library.define_tag("Namespace", :namespace)
      YARD::Tags::Library.define_tag("Default Value", :default_value)
      YARD::Tags::Library.define_tag("Example Value", :example_value)
      YARD::Tags::Library.define_tag("Required", :required)
      YARD::Tags::Library.define_tag("Unique", :unique)

      # Controllers
      YARD::Tags::Library.define_tag("Api Version", :api_version)
      YARD::Tags::Library.define_tag("Resource", :resource)
      YARD::Tags::Library.define_tag("Route", :route)
      YARD::Tags::Library.define_tag("Action", :action)
      YARD::Tags::Library.define_tag("Response Type", :response_type)
      YARD::Tags::Library.define_tag("Response", :response, :with_name)
      YARD::Tags::Library.define_tag("Body Param", :body_param, :with_types_and_name)

      return nil
    end

    # @param db_folder [String]
    # @return [void]
    def self.generate_model_db(db_folder:)

      register_custom_tags()

      files = [
        "app/models/**/*.rb",
      ]
      options = [
        "--no-output",       # we just need the metadata, not the HTML
        "--db=#{db_folder}", # don't want to mess up any existing yard db
      ]

      yardoc = YARD::CLI::Yardoc.new()
      yardoc.run(*(options + files))

      return nil
    end

  end
end
