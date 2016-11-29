module Mercadopago
  class Api
    attr_accessor :access_token

    def initialize(args={})
      @app_key = args[:app_key]
      @app_secret = args[:app_secret]
      @callback_url = args[:callback_url]
      @access_token = args[:access_token]
      @endpoint_url = 'https://api.mercadopago.com'
      @auth_url = 'https://auth.mercadopago.com.ar'
      @debug = args[:debug]
    end

    include Mercadopago::Core::Auth
    include Mercadopago::Core::Payments

    private

    def get_request(action, params={}, headers={})
      begin
        parse_response(RestClient.get("#{@endpoint_url}#{action}", {params: params}.merge(headers)))
      rescue => e
        parse_response(e.response)
      end
    end

    def post_request(action, params={}, headers={})
      begin
        parse_response(RestClient.post("#{@endpoint_url}#{action}", params, headers))
      rescue => e
        parse_response(e.response)
      end
    end

    def put_request(action, params={}, headers={})
      begin
        parse_response(RestClient.put("#{@endpoint_url}#{action}", params, headers))
      rescue => e
        parse_response(e.response)
      end
    end

    def patch_request(action, params={}, headers={})
      begin
        parse_response(RestClient.patch("#{@endpoint_url}#{action}", params, headers))
      rescue => e
        parse_response(e.response)
      end
    end

    def head_request(action, params={})
      begin
        parse_response(RestClient.head("#{@endpoint_url}#{action}", params))
      rescue => e
        parse_response(e.response)
      end
    end

    def delete_request(action, params={})
      begin
        parse_response(RestClient.delete("#{@endpoint_url}#{action}", params))
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
