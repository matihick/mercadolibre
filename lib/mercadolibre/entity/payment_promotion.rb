module Mercadolibre
  module Entity
    class PaymentPromotion
      def self.attr_list
        [:card_issuer, :labels, :thumbnail, :secure_thumbnail,
         :payer_costs, :accepted_bins, :total_financial_cost]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'card_issuer'
            self.card_issuer = CardIssuer.new(v) unless v.nil?
          elsif k.to_s == 'payer_costs'
            self.payer_costs = v.map { |x| PaymentPlan.new(x) } unless v.nil?
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
