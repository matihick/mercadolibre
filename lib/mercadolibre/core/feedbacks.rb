module Mercadolibre
  module Core
    module Feedbacks
      def get_order_feedbacks(order_id)
        filters = { access_token: @access_token }

        get_request("/orders/#{order_id}/feedback", filters).body
      end

      def get_order_buyer_feedback(order_id)
        filters = { access_token: @access_token }

        get_request("/orders/#{order_id}/feedback/purchase", filters).body
      end

      def get_order_seller_feedback(order_id)
        filters = { access_token: @access_token }

        get_request("/orders/#{order_id}/feedback/sale", filters).body
      end

      def create_order_feedback(order_id, feedback_data)
        payload = feedback_data.to_json

        headers = { content_type: :json }

        post_request("/orders/#{order_id}/feedback?access_token=#{@access_token}", payload, headers).body
      end

      def change_order_seller_feedback(order_id, kind, feedback_data)
        payload = feedback_data.to_json

        headers = { content_type: :json }

        put_request("/orders/#{order_id}/feedback/sale?access_token=#{@access_token}", payload, headers).body
      end

      def change_order_buyer_feedback(order_id, kind, feedback_data)
        payload = feedback_data.to_json

        headers = { content_type: :json }

        put_request("/orders/#{order_id}/feedback/purchase?access_token=#{@access_token}", payload, headers).body
      end

      def change_order_feedback(feedback_id, feedback_data)
        payload = feedback_data.to_json

        headers = { content_type: :json }

        put_request("/feedback/#{feedback_id}?access_token=#{@access_token}", payload, headers).body
      end

      def reply_order_feedback(feedback_id, text)
        payload = { reply: text }.to_json

        headers = { content_type: :json }

        post_request("/feedback/{feedback_id}/reply?access_token=#{@access_token}", payload, headers).body
      end
    end
  end
end
