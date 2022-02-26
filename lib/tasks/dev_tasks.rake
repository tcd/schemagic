require "yard"

YARD::Rake::YardocTask.new("dev:yard:gem") do |t|
  # t.files   = ['features/**/*.feature', 'features/**/*.rb', 'lib/**/*.rb']
end

YARD::Rake::YardocTask.new("schemagic:yard:_dummy") do |t|
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

      task(:generate) do
        Dir.chdir("./test/dummy") do
          Rake::Task["schemagic:yard:_dummy"].invoke
        end
      end

      task(:serve) do
        Dir.chdir("./test/dummy") do
          Rake::Task["schemagic:yard:_dummy"].invoke
        end
      end

    end
  end
end
