module Mercadolibre
  module Entity
    class FeaturedItem
      def self.attr_list
        [:item_id, :title, :price, :currency_id, :permalink, :picture,
         :accepts_mercado_pago, :category_id, :pool_id, :seller_id]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'picture'
            self.picture = ItemPicture.new(v)
          else
            self.send("#{k}=", v) if self.respond_to?(k)
          end
        end

        self.last_updated = date_created if last_updated.nil?
      end

      private

      attr_writer *attr_list
    end
  end
end
