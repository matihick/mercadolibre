module Mercadolibre
  module Core
    module ItemsAndSearches
      def get_my_item_ids(filters={})
        user_id = get_my_user.id

        filters.merge!({ access_token: @access_token, limit: 50, offset: 0 })

        get_request("/users/#{user_id}/items/search", filters).body
      end

      def get_item_ids(filters={})
        get_request("/sites/#{@site}/search", filters).body
      end

      def search_items(filters={})
        get_request("/sites/#{@site}/search", filters).body
      end

      def get_item(item_id)
        get_request("/items/#{item_id}").body
      end

      def get_item_visits(item_ids)
        if item_ids.is_a? Array
          result = { }

          item_ids.each_slice(50) do |ids_group|
            filters = { ids: ids_group.join(','), api_response_kind: 'hash' }
            result.merge!(get_request('/visits/items', filters).body)
          end

          result
        else
          filters = { ids: ids_group.join(','), api_response_kind: 'hash' }
          get_request('/visits/items', filters).body[item_ids]
        end
      end

      def get_item_description(item_id)
        get_request("/items/#{item_id}/description").body
      end

      def get_item_descriptions(item_id)
        get_request("/items/#{item_id}/descriptions").body
      end

      def get_item_available_upgrades(item_id)
        get_request("/items/#{item_id}/available_upgrades?access_token=@access_token").body
      end

      def get_search_url(site_id, q)
        get_request("/sites/#{site_id}/searchUrl?q=#{q}").body.url
      end

      def get_hot_items(site_id, category_id, limit=15)
        get_request("/sites/#{site_id}/hot_items/search?category=#{category_id}&limit=#{limit}").body
      end

      def get_featured_items(site_id, pool_id)
        get_request("/sites/#{site_id}/featured_items/#{pool_id}").body
      end

      def get_site_trends(site_id, category_id=nil)
        if category_id.present?
          params = { category: category_id }
        else
          params = { }
        end

        get_request("/sites/#{site_id}/trends/search", params).body
      end

      def item_valid?(attribs)
        payload = attribs.to_json

        headers = { content_type: :json }

        result = post_request("/items/validate?access_token=#{@access_token}", payload, headers)

        (result.status_code.to_s == '204')
      end

      def create_item(attribs)
        payload = attribs.to_json

        headers = { content_type: :json }

        post_request("/items?access_token=#{@access_token}", payload, headers).body
      end

      def relist_item(item_id, price, quantity, listing_type_id)
        payload = { price: price, quantity: quantity, listing_type_id: listing_type_id }.to_json

        headers = { content_type: :json, accept: :json }

        post_request("/items/#{item_id}/relist?access_token=#{@access_token}", payload, headers).body
      end

      def update_item_fields(item_id, attribs)
        payload = attribs.to_json

        headers = { content_type: :json, accept: :json }

        put_request("/items/#{item_id}?access_token=#{@access_token}", payload, headers).body
      end

      def update_item_listing_type(item_id, listing_type_id)
        payload = { id: listing_type_id }.to_json

        headers = { content_type: :json, accept: :json }

        post_request("/items/#{item_id}/listing_type?access_token=#{@access_token}", payload, headers).body
      end

      def add_item_description(item_id, text)
        payload = { text: text }.to_json

        headers = { content_type: :json, accept: :json }

        post_request("/items/#{item_id}/descriptions?access_token=#{@access_token}", payload, headers).body
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

      def update_item_identifiers(item_id, attrs)
        payload = attrs.to_json

        headers = { content_type: :json }

        put_request("/items/#{item_id}/product_identifiers?access_token=#{@access_token}", payload, headers).status_code == 200
      end

      def get_item_identifiers(item_id)
        get_request("/items/#{item_id}/product_identifiers").body
      end
    end
  end
end
