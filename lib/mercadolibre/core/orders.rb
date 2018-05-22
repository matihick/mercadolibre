module Mercadolibre
  module Core
    module Orders
      def search_orders(filters={})
        if filters[:seller_id].present?
          seller_id = filters[:seller_id]
        else
          seller_id = get_my_user.id
        end

        orders_suffix = filters.delete(:orders_suffix).to_s

        filters.merge!({
          seller: seller_id,
          access_token: @access_token
        })

        get_request("/orders/search#{orders_suffix}", filters).body
      end

      def search_archived_orders(filters={})
        search_orders(filters.merge(orders_suffix: '/archived'))
      end

      def search_pending_orders(filters={})
        search_orders(filters.merge(orders_suffix: '/pending'))
      end

      def search_recent_orders(filters={})
        search_orders(filters.merge(orders_suffix: '/recent'))
      end

      def get_order(order_id)
        filters = { access_token: @access_token }
        get_request("/orders/#{order_id}", filters).body
      end

      def get_order_billing_info(order_id)
        filters = { access_token: @access_token }
        get_request("/orders/#{order_id}/billing_info", filters).body.billing_info
      end
    end
  end
end
