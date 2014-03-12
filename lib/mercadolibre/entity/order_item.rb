module Mercadolibre
  module Entity
    class OrderItem
      def self.attr_list
        [:currency_id, :item_id, :item_title, :quantity, :unit_price]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'item'
            self.item_id = v['id']
            self.item_title = v['title']
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
