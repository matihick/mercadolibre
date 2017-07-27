module Mercadolibre
  module Core
    module Pictures
      def create_picture(path_to_file)
        payload = { file: File.new(path_to_file, 'rb') }
        post_request("/pictures?access_token=#{@access_token}", payload).body
      end

      def get_pictures(picture_id)
        get_request("/pictures/#{picture_id}").body
      end

      def delete_picture(picture_id)
        delete_request("/pictures/#{picture_id}?access_token=#{@access_token}").body
      end

      def add_item_picture(picture_id, item_id)
        payload = { id: picture_id }.to_json

        headers = { content_type: :json }

        post_request("/items/#{item_id}/pictures?access_token=#{@access_token}",
          payload, headers).body
      end

      def replace_item_pictures(item_id, images)
        payload = images.to_json

        headers = { content_type: :json }

        put_request("/items/#{item_id}?access_token=#{@access_token}", payload, headers).body
      end
    end
  end
end
