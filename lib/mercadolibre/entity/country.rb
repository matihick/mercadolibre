module Mercadolibre
  module Entity
    class Country
      def self.attr_list
        [:id, :name, :locale, :currency_id, :decimal_separator,
          :thousands_separator, :time_zone, :states]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'states'
            self.states = v.map { |x| State.new(x) } unless v.nil?
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
