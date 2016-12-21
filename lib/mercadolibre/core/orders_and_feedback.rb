module Mercadolibre
  module Core
    module OrdersAndFeedback
      def search_archived_orders(filters={})
        filters.merge!({
          seller: get_my_user.id,
          access_token: @access_token
        })

        get_request('/orders/search/archived', filters).body
      end

      def search_pending_orders(filters={})
        filters.merge!({
          seller: get_my_user.id,
          access_token: @access_token
        })

        get_request('/orders/search/pending', filters).body
      end

      def search_orders(filters={})
        filters.merge!({
          seller: get_my_user.id,
          access_token: @access_token
        })

        get_request('/orders/search', filters).body
      end

      def get_order(order_id)
        filters = { access_token: @access_token }
        get_request("/orders/#{order_id}", filters).body
      end

      def get_order_notes(order_id)
        filters = { access_token: @access_token }
        get_request("/orders/#{order_id}/notes", filters).body
      end

      def create_order_note(order_id, text)
        payload = { note: text }.to_json

        headers = { content_type: :json, accept: :json }

        result = post_request("/orders/#{order_id}/notes?access_token=#{@access_token}", payload, headers)
        result.body.note
      end

      def update_order_note(order_id, note_id, text)
        payload = { note: text }.to_json

        headers = { content_type: :json, accept: :json }

        result = put_request("/orders/#{order_id}/notes/#{note_id}?access_token=#{@access_token}", payload, headers)
        result.body.note
      end

      def delete_order_note(order_id, note_id)
        result = delete_request("/orders/#{order_id}/notes/#{note_id}?access_token=#{@access_token}")
        result.status_code == 200
      end

      def get_order_feedbacks(order_id)
        filters = { version: '3.0', access_token: @access_token }

        get_request("/orders/#{order_id}/feedback", filters).body
      end

      def get_order_buyer_feedback(order_id)
        filters = { version: '3.0', access_token: @access_token }

        get_request("/orders/#{order_id}/feedback/purchase", filters).body
      end

      def get_order_seller_feedback(order_id)
        filters = { version: '3.0', access_token: @access_token }

        get_request("/orders/#{order_id}/feedback/sale", filters).body
      end

      def create_order_feedback(order_id, feedback_data)
        payload = feedback_data.to_json

        headers = { content_type: :json }

        post_request("/orders/#{order_id}/feedback?version=3.0&access_token=#{@access_token}", payload, headers).body
      end

      def change_order_seller_feedback(order_id, kind, feedback_data)
        payload = feedback_data.to_json

        headers = { content_type: :json }

        put_request("/orders/#{order_id}/feedback/sale?version=3.0&access_token=#{@access_token}", payload, headers).body
      end

      def change_order_buyer_feedback(order_id, kind, feedback_data)
        payload = feedback_data.to_json

        headers = { content_type: :json }

        put_request("/orders/#{order_id}/feedback/purchase?version=3.0&access_token=#{@access_token}", payload, headers).body
      end

      def change_order_feedback(feedback_id, feedback_data)
        payload = feedback_data.to_json

        headers = { content_type: :json }

        put_request("/feedback/#{feedback_id}?version=3.0&access_token=#{@access_token}", payload, headers).body
      end

      def reply_order_feedback(feedback_id, text)
        payload = { reply: text }.to_json

        headers = { content_type: :json }

        post_request("/feedback/{feedback_id}/reply?version=3.0&access_token=#{@access_token}", payload, headers).body
      end

      def get_order_messages(order_id, filters={})
        filters.merge!({
          access_token: @access_token
        })

        get_request("/messages/orders/#{order_id}", filters).body
      end

      def get_order_message(message_id)
        params = { access_token: @access_token }
        get_request("/messages/#{message_id}", params).body
      end

      def create_order_message(order_id, user_from, user_to, content_type, message, attachments=[])
        if content_type == 'plain'
          message_data = { plain: message }
        elsif content_type == 'html'
          message_data = { html: message }
        else
          raise 'invalid content type! Allowed options: plain,html.'
        end

        payload = {
          from: { user_id: user_from },
          to: [{
            user_id: user_to,
            resource: 'orders',
            resource_id: order_id,
            site_id: @site
          }],
          text: message_data,
          attachments: attachments
        }.to_json

        headers = { content_type: :json }

        post_request("/messages?access_token=#{@access_token}&application_id=#{@app_key}", payload, headers).body
      end

      def create_attachment(path_to_file)
        payload = { file: File.new(path_to_file, 'rb') }
        post_request("/messages/attachments?access_token=#{@access_token}", payload).body
      end

      def get_attachment(attachment_id)
        params = { access_token: @access_token }
        get_request("/messages/attachments/#{attachment_id}", params, { api_response_kind: 'raw' }).body
      end

      def get_site_payment_methods(site_id)
        results = get_request("/sites/#{site_id}/payment_methods")
        results.body
      end

      def get_site_payment_method_info(site_id, payment_method_id)
        results = get_request("/sites/#{site_id}/payment_methods/#{payment_method_id}")
        results.body
      end

      def get_orders_blacklist(user_id)
        results = get_request("/users/#{user_id}/order_blacklist?access_token=#{@access_token}")
        results.body.map { |r| r.user.id }
      end

      def add_user_to_orders_blacklist(seller_id, user_id)
        payload = { user_id: user_id }.to_json

        headers = { content_type: :json }

        url = "/users/#{seller_id}/order_blacklist?access_token=#{@access_token}"
        post_request(url, payload, headers).status_code == 200
      end

      def remove_user_from_orders_blacklist(seller_id, user_id)
        url = "/users/#{seller_id}/order_blacklist/#{user_id}?access_token=#{@access_token}"

        delete_request(url).status_code == 200
      end
    end
  end
end
