module Mercadolibre
  module Core
    module Money
      def get_collection(collection_id)
        filters = { access_token: @access_token }

        get_request("/collections/#{collection_id}", filters).body
      end

      def get_payment(payment_id)
        get_request("/payments/#{payment_id}", { access_token: @access_token }).body
      end

      def get_user_mercadopago_balance(user_id)
        params = { access_token: @access_token }

        get_request("/users/#{user_id}/mercadopago_account/balance", params).body
      end
    end
  end
end
