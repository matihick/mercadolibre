module Mercadolibre
  module Core
    module Apps
      def get_application_info
        get_request("/applications/#{@app_key}", { access_token: @access_token }).body
      end

      def revoke_application_permissions(user_id, application_id)
        delete_request("/users/#{user_id}/applications/#{app_id}?access_token=#{@access_token}").body
      end

      def get_application_feeds
        get_request("/users/#{user_id}/applications/#{@app_key}", { access_token: @access_token }).body
      end
    end
  end
end
