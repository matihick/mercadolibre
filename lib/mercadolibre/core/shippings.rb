module Mercadolibre
  module Core
    module Shippings
      def get_shipment(shipment_id)
        filters = { access_token: @access_token }
        r = get_request("/shipments/#{shipment_id}", filters)

        Mercadolibre::Entity::Shipment.new(r[:body])
      end
    end
  end
end
