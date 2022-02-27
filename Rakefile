require "bundler/setup"
require "bundler/gem_tasks"

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# require "yard"
# require "schemagic/utility"

Dir["lib/tasks/development/*.rake"].each { |rake| load rake }
