module Mercadopago
  module Entity
    class AdditionalInfo
      def self.attr_list
        [:items, :payer, :shipments]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'payer'
            self.payer = Payer.new(v) unless v.nil?
          elsif k.to_s == 'shipments'
            self.shipments = Shipments.new(v) unless v.nil?
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
