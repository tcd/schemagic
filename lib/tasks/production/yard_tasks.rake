require "yard"
require "schemagic"

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

YARD::Rake::YardocTask.new("schemagic:yard:models") do |t|
  t.files   = ["app/**/*.rb"]
  t.options = [
    "--no-output",
    "--db=#{Schemagic::Utility.yard_db_folder()}",
  ]
end
