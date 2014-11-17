module Mercadolibre
  module Entity
    class Item
      def self.attr_list
        [:id, :site_id, :title, :subtitle, :seller_id, :category_id, :price,
        :base_price, :currency_id, :initial_quantity, :available_quantity, :sold_quantity,
        :buying_mode, :listing_type_id, :start_time, :stop_time, :condition, :permalink,
        :thumbnail, :secure_thumbnail, :pictures, :status, :sub_status, :parent_item_id,
        :automatic_relist, :date_created, :last_updated, :variation_id, :variation_attributes]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'pictures'
            self.pictures = v.map { |x| ItemPicture.new(x) } unless v.nil?
          elsif ['stop_time', 'last_updated', 'start_time', 'date_created'].include?(k.to_s)
            self.send("#{k}=", Time.parse(v)) unless v.nil?
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
