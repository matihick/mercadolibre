module Mercadolibre
  module Core
    module Items
      def create_item(attrs)
        payload = attrs.to_json

        headers = { content_type: :json }

        post_request("/items?access_token=#{@access_token}", payload, headers).body
      end

      def get_item(item_id, attrs={})
        get_request("/items/#{item_id}", attrs).body
      end

      def get_items(item_ids, attrs={})
        get_request("/items", attrs.merge(ids: item_ids.uniq.join(','))).body
      end

      def update_item(item_id, attrs)
        payload = attrs.to_json

        headers = { content_type: :json, accept: :json }

        put_request("/items/#{item_id}?access_token=#{@access_token}", payload, headers).body
      end

      def validate_item(attrs)
        payload = attrs.to_json

        headers = { content_type: :json }

        result = post_request("/items/validate?access_token=#{@access_token}", payload, headers)

        (result.status_code.to_s == '204')
      end

      def get_item_available_upgrades(item_id)
        get_request("/items/#{item_id}/available_upgrades?access_token=@access_token").body
      end

      def relist_item(item_id, attrs)
        payload = attrs.to_json

        headers = { content_type: :json, accept: :json }

        post_request("/items/#{item_id}/relist?access_token=#{@access_token}", payload, headers).body
      end

      def get_item_description(item_id)
        get_request("/items/#{item_id}/description").body
      end

      def update_item_description(item_id, text)
        payload = { text: text }.to_json

        headers = { content_type: :json, accept: :json }

        put_request("/items/#{item_id}/description?access_token=#{@access_token}", payload, headers).body
      end

      def update_item_attributes(item_id, attrs)
        payload = attrs.to_json

        headers = { content_type: :json, accept: :json }

        put_request("/items/#{item_id}?access_token=#{@access_token}", payload, headers).status_code == 200
      end

      def delete_item_attributes(item_id, attr_list)
        payload = attr_list.map { |x| { id: x } }.to_json

        headers = { content_type: :json, accept: :json }

        put_request("/items/#{item_id}?access_token=#{@access_token}", payload, headers).status_code == 200
      end

      def get_item_identifiers(item_id)
        get_request("/items/#{item_id}/product_identifiers").body
      end

      def update_item_identifiers(item_id, attrs)
        payload = attrs.to_json

        headers = { content_type: :json }

        put_request("/items/#{item_id}/product_identifiers?access_token=#{@access_token}", payload, headers).status_code == 200
      end
    end
  end
end
