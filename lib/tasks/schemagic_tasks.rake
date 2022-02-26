namespace(:schemagic) do

  desc("Explaining what the task does")
  task(:example) do
    puts("this is an example")
  end

end

require "yard"

YARD::Rake::YardocTask.new("schemagic:yard:gem") do |t|
  # t.files   = ['features/**/*.feature', 'features/**/*.rb', 'lib/**/*.rb']
  # t.options = ['--any', '--extra', '--opts'] # optional
end
