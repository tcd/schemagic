require "rails/generators"

namespace(:schemagic) do

  desc("Generate an initializer file at 'config/initializers/schemagic.rb' for Schemagic")
  task(install: [:environment]) do
    Rails::Generators.invoke("schemagic:initializer")
  end

  desc("Generate JSON schemas for Rails models")
  task(from_yard: [:environment]) do
    Schemagic::YardHelpers.generate_model_db()
    Schemagic::FromYard.generate()
  end

end
