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
        })[:body]

        @access_token = response['access_token']

        Mercadolibre::Entity::Auth.new({
          access_token: @access_token,
          refresh_token: response['refresh_token'],
          expired_at: response['expires_in'].to_i.seconds.from_now
        })
      end

      def generate_access_token
        response = post_request('/oauth/token', {
          grant_type: 'client_credentials',
          client_id: @app_key,
          client_secret: @app_secret
        })[:body]

        @access_token = response['access_token']

        Mercadolibre::Entity::Auth.new({
          access_token: @access_token,
          refresh_token: response['refresh_token'],
          expired_at: response['expires_in'].to_i.seconds.from_now
        })
      end

      def update_token(refresh_token)
        response = post_request('/oauth/token', {
          grant_type: 'refresh_token',
          client_id: @app_key,
          client_secret: @app_secret,
          refresh_token: refresh_token
        })[:body]

        @access_token = response['access_token']

        Mercadolibre::Entity::Auth.new({
          access_token: @access_token,
          refresh_token: response['refresh_token'],
          expired_at: response['expires_in'].to_i.seconds.from_now
        })
      end
    end
  end
end
