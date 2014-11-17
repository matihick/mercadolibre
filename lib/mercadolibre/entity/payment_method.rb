module Mercadolibre
  module Entity
    class PaymentMethod
      def self.attr_list
        [:id, :name, :payment_type_id, :card_issuer, :site_id, :thumbnail, :secure_thumbnail,
         :labels, :min_accreditation_days, :max_accreditation_days, :payer_costs,
         :exceptions_by_card_issuer, :card_configuration]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'card_issuer'
            self.card_issuer = CardIssuer.new(v) unless v.nil?
          elsif k.to_s == 'payer_costs'
            self.payer_costs = v.map { |x| PaymentPlan.new(x) } unless v.nil?
          elsif k.to_s == 'exceptions_by_card_issuer'
            self.exceptions_by_card_issuer = v.map { |x| PaymentPromotion.new(x) } unless v.nil?
          elsif k.to_s == 'card_configuration'
            self.card_configuration = v.map { |x| CardConfiguration.new(x) } unless v.nil?
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
