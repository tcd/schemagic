require "simplecov"

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
]

SimpleCov.start do

  add_filter("/bin/")
  add_filter("/coverage/")
  add_filter("/doc/")
  add_filter("/ignore/")
  add_filter("/test/")
  add_filter("/tmp/")

  # add_group("Schemagic", "/lib/schemagic")
  add_group("Schemagic", "/lib/schemagic")

  track_files("lib/**/*.rb")

end
