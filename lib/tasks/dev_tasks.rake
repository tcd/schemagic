require "fileutils"
require "yard"
require "schemagic/yard_helpers"

YARD::Rake::YardocTask.new("dev:yard:gem") do |t|
  t.files = ["lib/**/*.rb"]
end

namespace(:dev) do
  namespace(:yard) do
    namespace(:dummy) do

      task(:clean) do
        FileUtils.rm_rf("./test/dummy/.yardoc")
        FileUtils.rm_rf("./test/dummy/app/schema")
      end

      task(:generate) do
        db_folder = File.join(Dir.pwd(), "tmp", "schemagic", ".yardoc")
        Dir.chdir("./test/dummy") do
          Schemagic::YardHelpers.generate_model_db(db_folder: db_folder)
          # Schemagic::FromYard.generate()
        end
      end

    end
  end
end
