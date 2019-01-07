module Mercadoshops
  module Core
    module Orders
      def search_orders(seller_id, filters={})
        filters.merge!({ access_token: @access_token })

        get_request("/v1/shops/#{seller_id}/orders/search", filters).body
      end
    end
  end
end
