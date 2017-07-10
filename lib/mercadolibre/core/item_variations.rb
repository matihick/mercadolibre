module Mercadolibre
  module Core
    module ItemVariations
      def get_item_variations(item_id)
        get_request("/items/#{item_id}/variations").body
      end

      def create_item_variation(item_id, attrs)
        payload = attrs.to_json

        headers = { content_type: :json, accept: :json }

        post_request("/items/#{item_id}/variations?access_token=#{@access_token}",
          payload, headers).body
      end

      def get_item_variation(item_id, variation_id)
        get_request("/items/#{item_id}/variations/#{variation_id}").body
      end

      def update_item_variation(item_id, variation_id, attrs)
        payload = attrs.to_json

        headers = { content_type: :json, accept: :json }

        put_request("/items/#{item_id}/variations/#{variation_id}?access_token=#{@access_token}",
          payload, headers).body
      end

      def delete_item_variation(item_id, variation_id)
        delete_request("/items/#{item_id}/variations/#{variation_id}?access_token=#{@access_token}").body
      end
    end
  end
end
