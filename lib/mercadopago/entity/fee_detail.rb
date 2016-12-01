module Mercadopago
  module Entity
    class FeeDetail
      def self.attr_list
        [:amount, :fee_payer, :type]
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
