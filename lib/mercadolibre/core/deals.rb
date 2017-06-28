module Mercadolibre
  module Core
    # http://developers.mercadolibre.com/es/ofertas/
    module Deals
      def get_deals_invited(user_id)
        filters = { access_token: @access_token }

        get_request("/users/#{user_id}/deals/search", filters).body
      end

      def get_deal_products(user_id, deal_id)
        filters = { access_token: @access_token }

        get_request("/users/#{user_id}/deals/#{deal_id}/proposed_items/search", filters).body
      end

      def suggest_item_for_deal(user_id, deal_id, item_data)
        payload = item_data.to_json
        headers = { content_type: :json, accept: :json }

        post_request("/users/#{user_id}/deals/#{deal_id}/proposed_items?access_token=#{@access_token}",
          payload, headers).body
      end

      def update_deal_item(user_id, deal_id, item_data)
        payload = item_data.to_json
        headers = { content_type: :json, accept: :json }

        put_request("/users/#{user_id}/deals/#{deal_id}/proposed_items?access_token=#{@access_token}",
          payload, headers).body
      end

      def remove_item_from_deal(user_id, deal_id, item_id)
        delete_request("/users/#{user_id}/deals/#{deal_id}/proposed_items?access_token=#{@access_token}")
      end
    end
  end
end
