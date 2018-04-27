module Mercadolibre
  module Core
    module PickupStores
      def create_pickup_store(user_id, attrs)
        payload = attrs.to_json
        headers = { content_type: :json }

        post_request("/users/#{user_id}/stores?access_token=#{@access_token}", payload, headers).body
      end

      def update_pickup_store(user_id, store_id, attrs)
        payload = attrs.to_json
        headers = { content_type: :json, accept: :json }

        put_request("/users/#{user_id}/stores/#{store_id}?access_token=#{@access_token}", payload, headers).body
      end

      def delete_pickup_store(user_id, store_id)
        result = delete_request("/users/#{user_id}/stores/#{store_id}?access_token=#{@access_token}")
        result.status_code == 200
      end

      def search_pickup_stores(user_id, filters={})
        filters.merge!({ access_token: @access_token })
        get_request("/users/#{user_id}/stores/search", filters).body
      end

      def get_pickup_store(store_id)
        filters = { access_token: @access_token }
        get_request("/stores/#{store_id}", filters).body
      end

      def create_item_pickup_store(item_id, store_id, attrs)
        payload = attrs.to_json
        headers = { content_type: :json }

        post_request("/items/#{item_id}/stores/#{store_id}?access_token=#{@access_token}", payload, headers).body
      end

      def update_item_pickup_store(item_id, store_id, attrs)
        payload = attrs.to_json
        headers = { content_type: :json, accept: :json }

        put_request("/items/#{item_id}/stores/#{store_id}?access_token=#{@access_token}", payload, headers).body
      end

      def delete_item_pickup_store_from(item_id, store_id)
        result = delete_request("/items/#{item_id}/stores/#{store_id}?access_token=#{@access_token}")
        result.status_code == 200
      end

      def get_item_pickup_stores(item_id)
        filters = { access_token: @access_token }
        get_request("/items/#{item_id}/stores", filters).body
      end

      def get_pickup(pickup_id)
        filters = { access_token: @access_token }
        get_request("/pickups/#{pickup_id}", filters).body
      end
    end
  end
end
