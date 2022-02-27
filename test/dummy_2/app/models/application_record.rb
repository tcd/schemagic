class ApplicationRecord < ActiveRecord::Base

  primary_abstract_class()

  # ============================================================================
  # Attributes
  # ============================================================================

  # @!group Attributes

  # @!attribute [r] id
  #   @return [Integer]

  # @!attribute [r] display_name
  #   @return [String]

  # @!attribute [r] created_at
  #   @return [Time]

  # @!attribute [r] updated_at
  #   @return [Time]

  # @!endgroup Attributes

  # ============================================================================
  # Instance Methods
  # ============================================================================

  # @return [String]
  def display_name()
    return " " unless self.persisted?
    return self&.name || " "
  end

end
