module Mercadolibre
  module Entity
    class Payment
      def self.attr_list
        [:id, :status, :transaction_amount, :currency_id, :date_created, :date_last_updated]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if ['date_last_updated', 'date_created'].include?(k.to_s)
            self.send("#{k}=", Time.parse(v)) unless v.nil?
          else
            self.send("#{k}=", v) if self.respond_to?(k)
          end
        end

        self.date_last_updated = date_created if date_last_updated.nil?
      end

      private

      attr_writer *attr_list
    end
  end
end
