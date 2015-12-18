module Mercadolibre
  class Api
    attr_accessor :access_token

    def initialize(args={})
      @app_key = args[:app_key]
      @app_secret = args[:app_secret]
      @callback_url = args[:callback_url]
      @site = args[:site]
      @access_token = args[:access_token]
      @endpoint_url = 'https://api.mercadolibre.com'
      @auth_url = 'https://auth.mercadolibre.com.ar'
      @debug = args[:debug]
      @environment = args[:environment] || :production
    end

    include Mercadolibre::Core::Auth
    include Mercadolibre::Core::CategoriesAndListings
    include Mercadolibre::Core::ItemsAndSearches
    include Mercadolibre::Core::LocationsAndCurrencies
    include Mercadolibre::Core::OrderManagement
    include Mercadolibre::Core::Questions
    include Mercadolibre::Core::Shippings
    include Mercadolibre::Core::Users

    private

    def default_args
      {
        url: @endpoint_url,
        verify_ssl: @environment == :production
      }
    end

    def merged_args(args)
      default_args.merge(args) do |key, old_val, new_val|
        new_val = old_val + new_val if key == :url
        new_val
      end
    end

    def get_request(action, params={}, headers={})
      execute_request(method: :get, url: action, headers: headers.merge(params: params))
    end

    def post_request(action, payload={}, headers={})
      execute_request(method: :post, url: action, payload: payload, headers: headers)
    end

    def put_request(action, payload={}, headers={})
      execute_request(method: :put, url: action, payload: payload, headers: headers)
    end

    def patch_request(action, payload={}, headers={})
      execute_request(method: :patch, url: action, payload: payload, headers: headers)
    end

    def head_request(action, params={})
      execute_request(method: :get, url: action, headers: params)
    end

    def delete_request(action, params={})
      execute_request(method: :get, url: action, headers: params)
    end

    def execute_request(args)
      begin
        parse_response(RestClient::Request.execute(merged_args(args)))
      rescue => e
        parse_response(e.response)
      end
    end

    def parse_response(response)
      result = {
        headers: response.headers,
        body: (JSON.parse(response.body) rescue response.body),
        status_code: response.code
      }

      p "DEBUG: #{result}" if @debug

      result
    end
  end
end
