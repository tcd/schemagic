module Models
  # @model
  class VersionData

    # ============================================================================
    # Attributes
    # ============================================================================

    # @!group Attributes

    # @!attribute version [r]
    #   @return [String]

    # @!attribute environment [r]
    #   @return [String]

    # @!endgroup Attributes

    # @return [VersionResponse]
    def initialize()
      self.version = Dummy2::Application::VERSION
      self.environment = Rails.env
    end

    # ==========================================================================
    # Instance Methods
    # ==========================================================================

    # @return [Hash]
    def to_h()
      return {
        version: self.version,
        environment: self.environment,
      }
    end

  end
end
