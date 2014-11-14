module Mercadolibre
  module Entity
    class Payment
      def self.attr_list
        [:id, :order_id, :payer_id, :collector, :card_id, :site_id, :reason, :payment_method_id,
         :currency_id, :installments, :issuer_id, :atm_transfer_reference, :coupon_id, :activation_uri,
         :operation_type, :payment_type, :available_actions, :status, :status_code, :status_detail,
         :transaction_amount, :shipping_cost, :coupon_amount, :overpaid_amount, :total_paid_amount,
         :date_created, :date_last_modified]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if ['date_last_modified', 'date_created'].include?(k.to_s)
            self.send("#{k}=", Time.parse(v)) unless v.nil?
          elsif k.to_s == 'collector'
            self.collector = Collector.new(v) unless v.nil?
          elsif k.to_s == 'atm_transfer_reference'
            self.atm_transfer_reference = AtmTransferReference.new(v) unless v.nil?
          else
            self.send("#{k}=", v) if self.respond_to?(k)
          end
        end

        self.date_last_modified = date_created if date_last_modified.nil?
      end

      private

      attr_writer *attr_list
    end
  end
end
