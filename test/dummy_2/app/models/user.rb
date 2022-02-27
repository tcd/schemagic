class User < ApplicationRecord

  # ============================================================================
  # Attributes
  # ============================================================================

  # @!group Attributes

  # @!attribute email_address
  #   Email Address number of the User.
  #   @required
  #   @return [String]
  validates("email_address", presence: true, uniqueness: true)

  # @!attribute phone_number
  #   Telephone number of the User.
  #   @return [String]

  # @!attribute age_in_years
  #   Age of the User.
  #   @return [Integer]

  # @!attribute date_of_birth
  #   The User's date of birth.
  #   @return [Date]

  # @!attribute datetime_of_birth
  #   The User's date and time of birth.
  #   @return [Time]

  # @!endgroup Attributes

  # ============================================================================
  # Instance Methods
  # ============================================================================

  # @return [String]
  def display_name()
    return self.email_address
  end

end
