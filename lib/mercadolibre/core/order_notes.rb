module Mercadolibre
  module Core
    module OrderNotes
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
    end
  end
end
