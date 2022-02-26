# Generate an initializer file for Schemagic.
class InitGenerator < Rails::Generators::Base

  desc("This generator creates an initializer file at 'config/initializers/schemagic.rb' for Schemagic")

  source_root(File.expand_path("templates", __dir__))

  # @return [void]
  def copy_initializer()
    template("schemagic.rb.erb", "config/initializers/schemagic.rb")
  end

end
