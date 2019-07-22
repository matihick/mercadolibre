module Mercadoshops
  module Core
    module Orders
      def search_orders(seller_id, filters={})
        filters.merge!({ access_token: @access_token })

        get_request("/shops/#{seller_id}/orders/search", filters).body
      end

      def get_order(order_id)
        filters.merge!({ access_token: @access_token })

        get_request("/shops/#{seller_id}/orders/#{order_id}", filters).body
      end
    end
  end
end
