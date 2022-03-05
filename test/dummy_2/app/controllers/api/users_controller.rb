module Api
  # @api_version 1.0.0
  # @resource User
  class UsersController < ApiController

    # Returns information about all Users.
    #
    # @route /api/v1/users
    # @action GET
    #
    # @response 200 Ok
    #
    # @response_type [Array<User>]
    def index()
      @resource = User.all()
      render_json(@resource)
    end

    # Returns detailed information about a single User.
    #
    # @route /api/v1/users/{id}
    # @action GET
    #
    # @response 200 Ok
    # @response 404 Not Found
    #
    # @response_type [User]
    def show()
      @resource = User.find(id_param())
      render_json(@resource)
    end

    # Creates a new User.
    #
    # @route /api/v1/users
    # @action POST
    #
    # @response 201 Created
    # @response 422 Unprocessable Entity
    #
    # @response_type [User]
    def create()
      @resource = User.create!(create_params())
      render_json(@resource)
    end

    # Updates an existing User.
    #
    # @route /api/v1/users/{id}
    # @action PUT
    # @action PATCH
    #
    # @response 201 Created
    # @response 404 Not Found
    # @response 422 Unprocessable Entity
    #
    # @response_type [User]
    def update()
      @resource = User.find(id_param())
      @resource.update!(update_params())
      render_json(@resource)
    end

    # Deletes an existing User.
    #
    # @route /api/v1/users/{id}
    # @action DELETE
    #
    # @response 200 Ok
    # @response 404 Not Found
    def destroy()
      @resource = User.find(id_param())
      @resource&.destroy()
      render_json(@resource)
    end

    private

    def id_param()
      params.require(:id)
    end

    def create_params()
      params
        .require(:user)
        .permit(
          :email_address,
          # :password,
          :phone_number,
          :age_in_years,
          :date_of_birth,
          :datetime_of_birth,
        )
    end

    def update_params()
      params
        .require(:user)
        .permit(
          # :password,
          :phone_number,
          :age_in_years,
          :date_of_birth,
          :datetime_of_birth,
        )
    end

  end
end
