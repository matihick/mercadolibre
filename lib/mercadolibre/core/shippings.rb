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

      def get_shipping_options(item_id)
        get_request("/items/#{item_id}/shipping_options").body
      end

      def get_shipping_modes
        get_request("/sites/#{@site}/shipping_methods").body
      end

      def get_shipping_services
        get_request("/sites/#{@site}/shipping_services").body
      end

      def get_site_shipping_costs(attrs={})
        get_request("/sites/#{@site}/shipping_options", attrs).body
      end

      def get_user_shipping_modes(user_id, attrs={})
        get_request("/users/#{user_id}/shipping_modes", attrs).body
      end

      def get_user_shipping_costs(user_id, attrs={})
        get_request("/users/#{user_id}/shipping_options", attrs).body
      end

      def get_user_shipping_preferences(user_id)
        get_request("/users/#{user_id}/shipping_preferences").body
      end

      def get_order_shipments(order_id)
        filters = { access_token: @access_token }
        get_request("/orders/#{order_id}/shipments", filters).body
      end

      def get_shipment_labels(shipment_ids, attrs={})
        if shipment_ids.is_a?(Array)
          shipment_ids_data = shipment_ids.join(',')
        else
          shipment_ids_data = shipment_ids
        end

        filters = attrs.merge({
          access_token: @access_token,
          shipment_ids: shipment_ids_data
        })

        get_request('/shipment_labels', filters, { api_response_kind: 'raw' }).body
      end
    end
  end
end
