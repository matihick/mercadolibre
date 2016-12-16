module Mercadolibre
  class Api
    attr_accessor :access_token

    def initialize(args={})
      @app_key = args[:app_key]
      @app_secret = args[:app_secret]
      @callback_url = args[:callback_url]
      @access_token = args[:access_token]
      @endpoint_url = 'https://api.mercadolibre.com'
      @auth_url = 'https://auth.mercadolibre.com.ar'
      @site = args[:site]
    end

    include Mercadolibre::Core::Auth
    include Mercadolibre::Core::CategoriesAndListings
    include Mercadolibre::Core::Collections
    include Mercadolibre::Core::ItemsAndSearches
    include Mercadolibre::Core::LocationsAndCurrencies
    include Mercadolibre::Core::OrderManagement
    include Mercadolibre::Core::Questions
    include Mercadolibre::Core::Shippings
    include Mercadolibre::Core::Users

    def get_last_response
      @last_response
    end

    private

    def get_request(action, params={}, headers={})
      begin
        api_response_kind = params.delete('api_response_kind')
        api_response_kind = params.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.get("#{@endpoint_url}#{action}", {params: params}.merge(headers)))
      rescue => e
        parse_response('object', e.response)
      end
    end

    def post_request(action, params={}, headers={})
      begin
        api_response_kind = params.delete('api_response_kind')
        api_response_kind = params.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.post("#{@endpoint_url}#{action}", params, headers))
      rescue => e
        parse_response('object', e.response)
      end
    end

    def put_request(action, params={}, headers={})
      begin
        api_response_kind = params.delete('api_response_kind')
        api_response_kind = params.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.put("#{@endpoint_url}#{action}", params, headers))
      rescue => e
        parse_response('object', e.response)
      end
    end

    def patch_request(action, params={}, headers={})
      begin
        api_response_kind = params.delete('api_response_kind')
        api_response_kind = params.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.patch("#{@endpoint_url}#{action}", params, headers))
      rescue => e
        parse_response('object', e.response)
      end
    end

    def head_request(action, params={})
      begin
        api_response_kind = params.delete('api_response_kind')
        api_response_kind = params.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.head("#{@endpoint_url}#{action}", params))
      rescue => e
        parse_response('object', e.response)
      end
    end

    def delete_request(action, params={})
      begin
        api_response_kind = params.delete('api_response_kind')
        api_response_kind = params.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.delete("#{@endpoint_url}#{action}", params))
      rescue => e
        parse_response('object', e.response)
      end
    end

    def parse_response(api_response_kind, response)
      @last_response = response

      result = OpenStruct.new
      result.status_code = response.code

      if api_response_kind == 'object'
        result.headers = (JSON.parse(response.headers.to_json, object_class: OpenStruct) rescue response.headers)
        result.body = (JSON.parse(response.body, object_class: OpenStruct) rescue response.body)
      elsif api_response_kind == 'hash'
        result.headers = response.headers
        result.body = (JSON.parse(response.body) rescue response.body)
      else
        result.headers = response.headers
        result.body = response.body
      end

      result
    end
  end
end
