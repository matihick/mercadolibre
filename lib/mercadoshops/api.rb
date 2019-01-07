module Mercadoshops
  class Api
    attr_accessor :access_token

    def initialize(args={})
      @access_token = args[:access_token]

      if args[:endpoint_url].present?
        @endpoint_url = args[:endpoint_url]
      else
        @endpoint_url = 'https://api.mercadoshops.com/v1'
      end
    end

    include Mercadoshops::Core::Orders

    def get_last_response
      @last_response
    end

    def get_last_result
      @last_result
    end

    private

    def get_request(action, params={}, headers={})
      begin
        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.get("#{@endpoint_url}#{action}", {params: params}.merge(headers)))
      rescue => e
        parse_response('object', e.response)
      end
    end

    def post_request(action, params={}, headers={})
      begin
        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.post("#{@endpoint_url}#{action}", params, headers))
      rescue => e
        parse_response('object', e.response)
      end
    end

    def put_request(action, params={}, headers={})
      begin
        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.put("#{@endpoint_url}#{action}", params, headers))
      rescue => e
        parse_response('object', e.response)
      end
    end

    def patch_request(action, params={}, headers={})
      begin
        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.patch("#{@endpoint_url}#{action}", params, headers))
      rescue => e
        parse_response('object', e.response)
      end
    end

    def head_request(action, params={}, headers={})
      begin
        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
        api_response_kind = 'object' if api_response_kind.nil?

        parse_response(api_response_kind, RestClient.head("#{@endpoint_url}#{action}", params))
      rescue => e
        parse_response('object', e.response)
      end
    end

    def delete_request(action, params={}, headers={})
      begin
        api_response_kind = headers.delete('api_response_kind')
        api_response_kind = headers.delete(:api_response_kind) if api_response_kind.nil?
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

      @last_result = result

      result
    end
  end
end
