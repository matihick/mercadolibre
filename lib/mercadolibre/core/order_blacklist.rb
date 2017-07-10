module Mercadolibre
  module Core
    module OrderBlacklist
      def get_orders_blacklist(user_id)
        results = get_request("/users/#{user_id}/order_blacklist?access_token=#{@access_token}")
        results.body.map { |r| r.user.id }
      end

      def add_user_to_orders_blacklist(seller_id, user_id)
        payload = { user_id: user_id }.to_json

        headers = { content_type: :json }

        url = "/users/#{seller_id}/order_blacklist?access_token=#{@access_token}"
        post_request(url, payload, headers).status_code == 200
      end

      def remove_user_from_orders_blacklist(seller_id, user_id)
        url = "/users/#{seller_id}/order_blacklist/#{user_id}?access_token=#{@access_token}"

        delete_request(url).status_code == 200
      end
    end
  end
end
