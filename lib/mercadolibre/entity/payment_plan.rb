module Mercadolibre
  module Entity
    class PaymentPlan
      def self.attr_list
        [:installments, :installment_rate, :labels, :min_allowed_amount, :max_allowed_amount]
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
