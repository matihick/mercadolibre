module Mercadolibre
  module Entity
    class Shipment
      def self.attr_list
        [:id, :mode, :created_by, :order_id, :order_cost, :site_id, :status, :substatus,
         :status_history, :date_created, :last_updated, :tracking_number, :tracking_method,
         :service_id, :sender_id, :sender_address, :receiver_id, :receiver_address, :shipping_items,
         :shipping_option, :comments, :date_first_printed, :market_place, :return_details,
         :application_id, :return_tracking_number, :cost_components, :picking_type]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if ['date_created', 'last_updated', 'date_first_printed'].include?(k.to_s)
            self.send("#{k}=", Time.parse(v)) unless v.nil?
          elsif k.to_s == 'status_history'
            self.status_history = ShipmentStatusHistory.new(v) unless v.nil?
          elsif k.to_s == 'sender_address'
            self.sender_address = Address.new(v) unless v.nil?
          elsif k.to_s == 'receiver_address'
            self.receiver_address = Address.new(v) unless v.nil?
          elsif k.to_s == 'shipping_items'
            self.shipping_items = v.map { |x| ShippingItem.new(x) }
          elsif k.to_s == 'shipping_option'
            self.shipping_option = ShippingOption.new(v) unless v.nil?
          elsif k.to_s == 'cost_components'
            self.cost_components = CostComponents.new(v) unless v.nil?
          else
            self.send("#{k}=", v) if self.respond_to?(k)
          end
        end
      end

      private

      attr_writer *attr_list
    end
  end
end
