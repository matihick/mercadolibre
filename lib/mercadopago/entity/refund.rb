module Mercadopago
  module Entity
    class Refund
      def self.attr_list
        [:id, :amount, :source, :reason, :date_created, :payment_id, :metadata, :unique_sequence_number]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'source'
            self.source = Source.new(v) unless v.nil?
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
