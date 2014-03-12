module Mercadolibre
  module Core
    module Items
      def get_all_my_item_ids(filters={})
        user_id = get_my_user.id

        filters.merge!({ access_token: @access_token, limit: 50, offset: 0 })

        results = []
        has_results = true

        pages_remaining = filters[:pages_count] || -1

        while (has_results && (pages_remaining != 0)) do
          partial_results = get_request("/users/#{user_id}/items/search", filters)[:body]['results']
          results += partial_results
          has_results = partial_results.any?
          filters[:offset] += 50
          pages_remaining -= 1
        end

        results
      end

      def get_my_item_ids(filters={})
        user_id = get_my_user.id

        filters.merge!({ access_token: @access_token, limit: 50, offset: 0 })

        response = get_request("/users/#{user_id}/items/search", filters)[:body]

        {
          results: response['results'],
          paging: response['paging']
        }
      end

      def get_all_item_ids(filters={})
        filters.merge!({ limit: 50, offset: 0 })

        results = []
        has_results = true

        pages_remaining = filters[:pages_count] || -1

        while (has_results && (pages_remaining != 0)) do
          partial_results = get_request("/sites/#{@site}/search", filters)[:body]['results']
          results += partial_results.map { |r| r['id'] }
          has_results = partial_results.any?
          filters[:offset] += 50
          pages_remaining -= 1
        end

        results
      end

      def get_item_ids(filters={})
        response = get_request("/sites/#{@site}/search", filters)[:body]

        {
          results: response['results'].map { |r| r['id'] },
          paging: response['paging']
        }
      end

      def get_item_visits(item_ids)
        if item_ids.is_a? Array
          get_request("/visits/items?ids=#{item_ids.join(',')}")[:body]
        else
          get_request("/visits/items?ids=#{item_ids}")[:body][item_ids]
        end

      end

      def create_item(attribs)
        payload = attribs.to_json

        headers = { content_type: :json }

        result = post_request("/items?access_token=#{@access_token}", payload, headers)

        Mercadolibre::Entity::Item.new(result[:body])
      end

      def relist_item(item_id, price, quantity, listing_type_id)
        payload = { price: price, quantity: quantity, listing_type_id: listing_type_id }.to_json

        headers = { content_type: :json, accept: :json }

        result = post_request("/items/#{item_id}/relist?access_token=#{@access_token}", payload, headers)

        Mercadolibre::Entity::Item.new(result[:body])
      end

      def get_item(item_id)
        result = get_request("/items/#{item_id}")

        Mercadolibre::Entity::Item.new(result[:body])
      end

      def add_item_description(item_id, text)
        payload = { text: text }.to_json

        headers = { content_type: :json, accept: :json }

        post_request("/items/#{item_id}/descriptions?access_token=#{@access_token}", payload, headers)[:body]
      end

      def update_item_fields(item_id, attribs)
        payload = attribs.to_json

        headers = { content_type: :json, accept: :json }

        put_request("/items/#{item_id}?access_token=#{@access_token}", payload, headers)[:body]
      end

      def update_item_listing_type(item_id, new_listing_kind)
        payload = { id: new_listing_kind }.to_json

        headers = { content_type: :json, accept: :json }

        post_request("/items/#{item_id}/listing_type?access_token=#{@access_token}", payload, headers)[:body]
      end
    end
  end
end
