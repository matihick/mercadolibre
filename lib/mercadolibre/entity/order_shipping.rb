module Mercadolibre
  module Entity
    class OrderShipping
      def self.attr_list
        [:shipping_option, :shipping_mode, :shipment_type, :shipping_items, :status,
        :currency_id, :sender_id, :receiver_address, :picking_type, :cost, :substatus,
        :id, :date_first_printed, :service_id, :receiver_id, :date_created]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'shipping_option'
            self.shipping_option = ShippingOption.new(v)
          elsif k.to_s == 'shipping_items'
            self.shipping_items = v.map { |x| ShippingItem.new(x) }
          elsif k.to_s == 'receiver_address'
            self.receiver_address = Address.new(v)
          elsif ['date_first_printed', 'date_created'].include?(k.to_s)
            self.send("#{k}=", Time.parse(v)) unless v.nil?
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
