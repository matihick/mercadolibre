module Mercadolibre
  module Core
    module Bookmarks
      def get_my_bookmarks
        get_request("/users/me/bookmarks", { access_token: @access_token }).body
      end

      def create_item_bookmark(item_id)
        payload = { item_id: item_id }.to_json

        headers = { content_type: :json }

        post_request("/users/me/bookmarks?access_token=#{@access_token}", payload, headers).body
      end

      def delete_item_bookmark(item_id)
        delete_request("/users/me/bookmarks/#{item_id}?access_token=#{@access_token}").body
      end
    end
  end
end
