module Mercadolibre
  module Core
    module Auth
      def authenticate_url
        get_attrs = {
          response_type: 'code',
          client_id: @app_key,
          redirect_uri: CGI.escape(@callback_url)
        }.map { |k,v| "#{k}=#{v}" }.join('&')

        "#{@auth_url}/authorization?#{get_attrs}"
      end

      def authenticate(auth_code)
        response = post_request('/oauth/token', {
          grant_type: 'authorization_code',
          client_id: @app_key,
          client_secret: @app_secret,
          code: auth_code,
          redirect_uri: @callback_url
        })

        @access_token = response.body.access_token
        response.body.expiration_time = (Time.now + response.body.expires_in.to_i)
        response.body
      end

      def update_token(refresh_token)
        response = post_request('/oauth/token', {
          grant_type: 'refresh_token',
          client_id: @app_key,
          client_secret: @app_secret,
          refresh_token: refresh_token
        })

        @access_token = response.body.access_token
        response.body.expiration_time = (Time.now + response.body.expires_in.to_i)
        response.body
      end
    end
  end
end
