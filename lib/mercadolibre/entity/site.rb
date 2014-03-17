module Mercadolibre
  module Entity
    class Country
      def self.attr_list
        [:id, :name, :country_id, :sale_fees_mode, :mercadopago_version, :default_currency_id,
         :currencies, :immediate_payment, :payment_method_ids, :categories]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'currencies'
            self.states = v.map { |x| Currency.new(x) }
          elsif k.to_s == 'categories'
            self.categories = v.map { |x| Category.new(x) }
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
