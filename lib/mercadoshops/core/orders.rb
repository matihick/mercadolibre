module Mercadoshops
  module Core
    module Orders
      def search_orders(seller_id, filters={})
        filters.merge!({ access_token: @access_token })

        get_request("/shops/#{seller_id}/orders/search", filters).body
      end
    end
  end
end
