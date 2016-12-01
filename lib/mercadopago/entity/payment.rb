module Mercadopago
  module Entity
    class Payment
      def self.attr_list
        [
          :id,
          :date_created,
          :date_approved,
          :date_last_updated,
          :money_release_date,
          :operation_type,
          :issuer_id,
          :payment_method_id,
          :payment_type_id,
          :status,
          :status_detail,
          :currency_id,
          :description,
          :live_mode,
          :sponsor_id,
          :authorization_code,
          :collector_id,
          :collector,
          :payer,
          :metadata,
          :order,
          :external_reference,
          :transaction_amount,
          :transaction_amount_refunded,
          :coupon_amount,
          :shipping_cost,
          :differential_pricing_id,
          :deduction_schema,
          :transaction_details,
          :fee_details,
          :captured,
          :binary_mode,
          :call_for_authorize_id,
          :statement_descriptor,
          :installments,
          :card,
          :notification_url,
          :refunds,
          :payer,
          :application_id,
          :additional_info
        ]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        time_fields = ['date_created', 'date_approved', 'date_last_updated', 'money_release_date']

        attributes.each do |k, v|
          if time_fields.include?(k.to_s)
            self.send("#{k}=", Time.parse(v)) unless v.nil?
          elsif k.to_s == 'payer'
            self.payer = Payer.new(v)
          elsif k.to_s == 'collector'
            self.collector = Collector.new(v)
          elsif k.to_s == 'refunds'
            self.refunds = v.map { |x| Refund.new(x) }
          elsif k.to_s == 'transaction_details'
            self.transaction_details = TransactionDetails.new(v)
          elsif k.to_s == 'additional_info'
            self.additional_info = AdditionalInfo.new(v)
          elsif k.to_s == 'fee_details'
            self.fee_details = v.map { |x| FeeDetail.new(x) }
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
