require "schemagic/version"
require "schemagic/errors"
require "schemagic/railtie"
require "schemagic/utility"
require "schemagic/config"
# require "schemagic/from_yard"

# Generate JSON schemas from Rails models & Rails models from JSON schemas.
module Schemagic

  # Configuration for Schemagic
  #
  # @return [Schemagic::Config]
  def self.config()
    @config ||= Config.new()
  end

  # Modify Schemagic's current config.
  #
  # @example
  #   Schemagic.configure do |config|
  #     config.
  #   end
  #
  # @yieldparam [Schemagic::Config] config current Schemagic config
  # @return [void]
  def self.configure()
    yield self.config()
  end

end
