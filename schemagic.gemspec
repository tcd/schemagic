require_relative "lib/schemagic/version"

Gem::Specification.new do |spec|
  spec.name        = "schemagic"
  spec.version     = Schemagic::VERSION
  spec.authors     = ["Clay Dunston"]
  spec.email       = ["dunstontc@gmail.com"]
  spec.homepage    = "https://github.com/tcd/schemagic"
  spec.summary     = "Schema Magic"
  spec.description = spec.summary
  spec.license     = "MIT"

  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "#{spec.homepage}.git"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"
  spec.metadata["yard.run"] = "yri" # use "yard" to build full HTML docs.

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency("rails", ">= 7.0.2.2")
  spec.add_dependency("yard", "~> 0.9.27")

  spec.add_development_dependency("pry", "~> 0.14.1")
  spec.add_development_dependency("rubocop", "~> 1.25")
  spec.add_development_dependency("simplecov", "~> 0.21.2")
  spec.add_development_dependency("solargraph", "~> 0.44.3")
  spec.add_development_dependency("sqlite3")
end
