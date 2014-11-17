module Mercadolibre
  module Entity
    class ShippingOption
      def self.attr_list
        [:id, :shipping_method_id, :name, :currency_id, :list_cost,
         :cost, :speed, :estimated_delivery]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'speed'
            self.speed = ShippingSpeed.new(v) unless v.nil?
          elsif k.to_s == 'estimated_delivery'
            self.estimated_delivery = ShippingDelivery.new(v) unless v.nil?
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
