module Mercadolibre
  module Core
    module ItemsAndSearches
      def get_my_item_ids(filters={})
        user_id = get_my_user.id

        filters.merge!({ access_token: @access_token, limit: 50, offset: 0 })

        response = get_request("/users/#{user_id}/items/search", filters)[:body]

        {
          results: response['results'],
          paging: response['paging']
        }
      end

      # This method is meant to be used when you need to save all data in your local database
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

      def get_item_ids(filters={})
        response = get_request("/sites/#{@site}/search", filters)[:body]

        {
          results: response['results'].map { |r| r['id'] },
          paging: response['paging']
        }
      end

      # This method is meant to be used when you need to save all data in your local database
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

      def search_items(filters={})
        response = get_request("/sites/#{@site}/search", filters)[:body]

        {
          results: response['results'].map { |x| Mercadolibre::Entity::Item.new(x) },
          paging: response['paging']
        }
      end

      # This method is meant to be used when you need to save all data in your local database
      def search_all_items(filters={})
        filters.merge!({ limit: 50, offset: 0 })

        results = []
        has_results = true

        pages_remaining = filters[:pages_count] || -1

        while (has_results && (pages_remaining != 0)) do
          partial_results = get_request("/sites/#{@site}/search", filters)[:body]['results']
          results += partial_results.map { |x| Mercadolibre::Entity::Item.new(x) }
          has_results = partial_results.any?
          filters[:offset] += 50
          pages_remaining -= 1
        end

        results
      end

      def get_item(item_id)
        result = get_request("/items/#{item_id}")

        Mercadolibre::Entity::Item.new(result[:body])
      end

      def get_item_visits(item_ids)
        if item_ids.is_a? Array
          result = { }

          item_ids.each_slice(50) do |ids_group|
            result.merge!(get_request("/visits/items?ids=#{ids_group.join(',')}")[:body])
          end

          result
        else
          get_request("/visits/items?ids=#{item_ids}")[:body][item_ids]
        end
      end

      def get_item_description(item_id)
        result = get_request("/items/#{item_id}/description")

        Mercadolibre::Entity::ItemDescription.new(result[:body])
      end

      def get_item_descriptions(item_id)
        results = get_request("/items/#{item_id}/descriptions")

        results[:body].map { |r| Mercadolibre::Entity::ItemDescription.new(r) }
      end

      def get_item_available_upgrades(item_id)
        results = get_request("/items/#{item_id}/available_upgrades?access_token=@access_token")

        results[:body].map { |r| Mercadolibre::Entity::ListingType.new(r) }
      end

      def get_search_url(site_id, q)
        result = get_request("/sites/#{site_id}/searchUrl?q=#{q}")
        result[:body]['url']
      end

      def get_hot_items(site_id, category_id, limit=15)
        results = get_request("/sites/#{site_id}/hot_items/search?category=#{category_id}&limit=#{limit}")

        results[:body].map { |r| Mercadolibre::Entity::Item.new(r) }
      end

      def get_featured_items(site_id, pool_id)
        results = get_request("/sites/#{site_id}/featured_items/#{pool_id}")

        results[:body].map { |r| Mercadolibre::Entity::FeaturedItem.new(r) }
      end

      def get_site_trends(site_id, category_id=nil)
        if category_id.present?
          params = { category: category_id }
        else
          params = { }
        end

        results = get_request("/sites/#{site_id}/trends/search", params)

        results[:body].map { |r| Mercadolibre::Entity::SiteTrend.new(r) }
      end

      def item_valid?(attribs)
        payload = attribs.to_json

        headers = { content_type: :json }

        result = post_request("/items/validate?access_token=#{@access_token}", payload, headers)

        (result[:status_code].to_s == '204')
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

      def update_item_fields(item_id, attribs)
        payload = attribs.to_json

        headers = { content_type: :json, accept: :json }

        put_request("/items/#{item_id}?access_token=#{@access_token}", payload, headers)[:body]
      end

      def update_item_listing_type(item_id, listing_type_id)
        payload = { id: listing_type_id }.to_json

        headers = { content_type: :json, accept: :json }

        post_request("/items/#{item_id}/listing_type?access_token=#{@access_token}", payload, headers)[:body]
      end

      def add_item_description(item_id, text)
        payload = { text: text }.to_json

        headers = { content_type: :json, accept: :json }

        post_request("/items/#{item_id}/descriptions?access_token=#{@access_token}", payload, headers)[:body]
      end
    end
  end
end
