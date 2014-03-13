module Mercadolibre
  module Entity
    class CurrencyConversionRatio
      def self.attr_list
        [:currency_from, :currency_to, :currency_id, :ratio, :mercado_pago_ratio]
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
