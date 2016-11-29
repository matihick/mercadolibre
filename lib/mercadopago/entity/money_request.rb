module Mercadopago
  module Entity
    class MoneyRequest
      def self.attr_list
        [:id, :status, :site_id, :currency_id, :amount, :collector_id, :collector_email, :payer_id, :payer_email,
          :description, :concept_type, :init_point, :external_reference, :pref_id, :date_created, :last_updated]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if ['date_created', 'last_updated'].include?(k.to_s)
            self.send("#{k}=", Time.parse(v)) unless v.nil?
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



{

}
