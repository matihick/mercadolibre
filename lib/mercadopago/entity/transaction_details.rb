module Mercadopago
  module Entity
    class TransactionDetails
      def self.attr_list
        [:net_received_amount,
          :total_paid_amount,
          :overpaid_amount,
          :external_resource_url,
          :installment_amount,
          :financial_institution,
          :payment_method_reference_id]
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
