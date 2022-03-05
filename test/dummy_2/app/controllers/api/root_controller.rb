module Api
  # @api_version 1.0.0
  class RootController < ApiController

    # Returns information about all Users.
    #
    # @route /api/v1
    # @action GET
    #
    # @response 200 Ok
    # @response_type [Models::VersionData]
    def index()
      @data = Models::VersionData.new()
      render_json(@data)
    end

  end
end
