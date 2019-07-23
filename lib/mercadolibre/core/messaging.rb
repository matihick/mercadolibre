module Mercadolibre
  module Core
    module Messaging
      def get_order_messages(order_id, filters={})
        filters.merge!({ access_token: @access_token })

        get_request("/messages/orders/#{order_id}", filters).body
      end

      def get_unread_order_messages(filters={})
        filters.merge!({ access_token: @access_token })

        get_request("/messages/pending_read", filters).body
      end

      def get_order_message(message_id)
        params = { access_token: @access_token }

        get_request("/messages/#{message_id}", params).body
      end

      def create_order_message(message_data)
        payload = message_data.to_json

        headers = { content_type: :json }

        post_request("/messages?access_token=#{@access_token}&application_id=#{@app_key}",
          payload, headers).body
      end

      def mark_order_message_as_read(message_ids)
        if message_ids.is_a?(Array)
          message_ids_data = message_ids.join(',')
        else
          message_ids_data = message_ids
        end

        headers = { content_type: :json }

        put_request("/messages/mark_as_read/#{message_ids_data}?access_token=#{@access_token}",
          payload, headers).body
      end

      def create_attachment(file)
        payload = { file: file }
        headers = { content_type: 'multipart/form-data' }
        post_request("/messages/attachments?access_token=#{@access_token}", payload, headers).body
      end

      def get_attachment(attachment_id)
        params = { access_token: @access_token }
        get_request("/messages/attachments/#{attachment_id}", params, { api_response_kind: 'raw' }).body
      end

      def get_pack_messages(pack_id, user_id, filters={})
        filters.merge!({ access_token: @access_token })

        get_request("/messages/packs/#{pack_id}/sellers/#{user_id}", filters).body
      end

      def create_pack_message(pack_id, user_id, message_data)
        url = "/messages/packs/#{pack_id}/sellers/#{user_id}?access_token=#{@access_token}"
        url += "&application_id=#{@app_key}"

        payload = message_data.to_json

        headers = { content_type: :json }

        post_request(url, payload, headers).body
      end
    end
  end
end
