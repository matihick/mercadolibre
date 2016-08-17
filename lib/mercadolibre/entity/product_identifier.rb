module Mercadolibre
  module Entity
    class ProductIdentifier
      def self.attr_list
        [:brand, :mpn, :gtins]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'gtins'
            self.gtins = v.map { |x| Gtin.new(x) } unless v.nil?
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
