module Mercadolibre
  module Core
    module Users
      def get_users(user_ids)
        get_request('/users', { ids: user_ids.join(',') }).body
      end

      def get_user(user_id)
        get_request("/users/#{user_id}", { access_token: @access_token }).body
      end

      def get_seller(nickname)
        response = search_items({ nickname: nickname, limit: 0 })
        if response.seller.present?
          get_user(response.seller.id)
        else
          nil
        end
      end

      def update_user(user_id, attrs)
        payload = attrs.to_json

        headers = { content_type: :json }

        put_request("/users/#{user_id}?access_token=#{@access_token}", payload, headers).body
      end

      def get_my_user
        get_request('/users/me', { access_token: @access_token }).body
      end

      def get_user_addresses(user_id)
        get_request("/users/#{user_id}/addresses", { access_token: @access_token }).body
      end

      def get_user_accepted_payment_methods(user_id)
        get_request("/users/#{user_id}/accepted_payment_methods").body
      end

      def get_user_payment_methods(user_id)
        get_request("/users/#{user_id}/payment_methods", { access_token: @access_token }).body
      end

      def get_user_brands(user_id)
        get_request("/users/#{user_id}/brands", { access_token: @access_token }).body
      end

      def get_user_brand(user_id, brand_id)
        get_request("/users/#{user_id}/brands/#{brand_id}", { access_token: @access_token }).body
      end

      def get_user_promotion_packs(user_id, listing_type=nil, category_id=nil)
        filters = { access_token: @access_token }

        if category_id.present?
          filters[:categoryId] = category_id
        end

        if listing_type.present?
          url = "/users/#{user_id}/classifieds_promotion_packs/#{listing_type}"
        else
          url = "/users/#{user_id}/classifieds_promotion_packs"
        end

        get_request(url, filters).body
      end

      def get_user_available_listing_types(user_id, category_id)
        filters = {
          access_token: @access_token,
          category_id: category_id
        }

        get_request("/users/#{user_id}/available_listing_types", filters).body
      end

      def get_user_listing_type_availability(listing_type, category_id)
        filters = {
          access_token: @access_token,
          category_id: category_id
        }

        get_request("/users/#{user_id}/available_listing_type/#{listing_type}", filters).body
      end
    end
  end
end
