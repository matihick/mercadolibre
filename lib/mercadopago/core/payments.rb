module Mercadopago
  module Core
    module Payments
      def get_payment(payment_id)
        filters = { access_token: @access_token }
        r = get_request("/v1/payments/#{payment_id}", filters)

        Mercadopago::Entity::Payment.new(r[:body])
      end

      def search_payments(filters={})
        filters.merge!({ access_token: @access_token })

        response = get_request('/v1/payments/search', filters)[:body]

        {
          results: response['results'].map { |r| Mercadopago::Entity::Payment.new(r) },
          paging: response['paging']
        }
      end

      def request_payment(attrs={})
        payload = attrs.to_json

        headers = { content_type: :json }

        result = post_request("/money_requests?access_token=#{@access_token}", payload, headers)

        Mercadopago::Entity::MoneyRequest.new(result[:body])
      end
    end
  end
end
