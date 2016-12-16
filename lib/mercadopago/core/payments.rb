module Mercadopago
  module Core
    module Payments
      def get_payment(payment_id)
        filters = { access_token: @access_token }
        get_request("/v1/payments/#{payment_id}", filters).body
      end

      def search_payments(filters={})
        filters.merge!({ access_token: @access_token })

        get_request('/v1/payments/search', filters).body
      end

      def request_payment(attrs={})
        payload = attrs.to_json

        headers = { content_type: :json }

        post_request("/money_requests?access_token=#{@access_token}", payload, headers).body
      end
    end
  end
end
