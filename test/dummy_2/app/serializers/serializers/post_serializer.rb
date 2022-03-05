module Serializers
  module V1
    class PostSerializer < BaseSerializer

      fields(
      )

      # ========================================================================

      view(:with_user) do
        association(:user, name: :user, blueprint: UserSerializer)
      end

    end
  end
end
