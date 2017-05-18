module Mercadopago
  module Core
    module Payments
      def get_payment(payment_id)
        filters = { access_token: @access_token }
        get_request("/payments/#{payment_id}", filters).body
      end

      def search_payments(filters={})
        filters.merge!({ access_token: @access_token })

        get_request('/payments/search', filters).body
      end

      def request_payment(attrs={})
        payload = attrs.to_json

        headers = { content_type: :json }

        post_request("/money_requests?access_token=#{@access_token}", payload, headers).body
      end

      def get_payment_request(payment_request_id)
        filters = { access_token: @access_token }
        get_request("/money_requests/#{payment_request_id}", filters).body
      end
    end
  end
end
