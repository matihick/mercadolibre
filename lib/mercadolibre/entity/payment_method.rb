module Mercadolibre
  module Entity
    class PaymentMethod
      def self.attr_list
        [:id, :name, :payment_type_id, :thumbnail, :secure_thumbnail]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          self.send("#{k}=", v) if self.respond_to?(k)
        end
      end

      private

      attr_writer *attr_list
    end
  end
end
