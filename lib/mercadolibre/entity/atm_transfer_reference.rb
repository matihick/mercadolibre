module Mercadolibre
  module Entity
    class AtmTransferReference
      def self.attr_list
        [:company_id, :transaction_id]
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
