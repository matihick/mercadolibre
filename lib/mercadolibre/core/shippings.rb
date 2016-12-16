module Mercadolibre
  module Core
    module Shippings
      def get_shipment(shipment_id)
        filters = { access_token: @access_token }
        get_request("/shipments/#{shipment_id}", filters).body
      end

      def update_shipment(shipment_id, attribs)
        payload = attribs.to_json

        headers = { content_type: :json, accept: :json }

        put_request("/shipments/#{shipment_id}?access_token=#{@access_token}", payload, headers).body
      end
    end
  end
end
