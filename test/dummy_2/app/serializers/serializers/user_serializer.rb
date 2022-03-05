module Serializers
  module V1
    class UserSerializer < BaseSerializer

      fields(
        :email_address,
        # :password,
        :phone_number,
        :age_in_years,
        :date_of_birth,
        :datetime_of_birth,
      )

      # ========================================================================

      view(:with_posts) do
        association(:posts, name: :posts, blueprint: PostSerializer)
      end

    end
  end
end
