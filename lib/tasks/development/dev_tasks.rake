require "fileutils"
require "yard"

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

YARD::Rake::YardocTask.new("dev:yard:gem") do |t|
  # t.files   = ['features/**/*.feature', 'features/**/*.rb', 'lib/**/*.rb']
end

YARD::Rake::YardocTask.new("dev:yard:_dummy") do |t|
  t.files = [
    "app/models/*.rb",
  ]
  # t.options = [
  #   "--output-dir='./test/dummy/doc'",
  # ]
end

namespace(:dev) do
  namespace(:yard) do
    namespace(:dummy) do

      task(:clean) do
        FileUtils.rm_rf("./test/dummy/.yardoc")
        FileUtils.rm_rf("./test/dummy/app/schema")
      end

      task(:generate) do
        Dir.chdir("./test/dummy") do
          Rake::Task["dev:yard:_dummy"].invoke
        end
      end

      # task(:serve) do
      #   Dir.chdir("./test/dummy") do
      #     Rake::Task["dev:yard:_dummy"].invoke
      #   end
      # end

    end
  end
end
