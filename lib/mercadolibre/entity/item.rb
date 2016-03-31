module Mercadolibre
  module Entity
    class Item
      def self.attr_list
        [:id, :site_id, :title, :subtitle, :seller_id, :category_id, :official_store_id,
         :price, :base_price, :original_price, :currency_id, :initial_quantity, :available_quantity,
         :sold_quantity, :buying_mode, :listing_type_id, :start_time, :stop_time, :condition, :permalink,
         :thumbnail, :secure_thumbnail, :pictures, :video_id, :descriptions, :accepts_mercadopago,
         :non_mercado_pago_payment_methods, :shipping, :seller_address, :seller_contact, :location,
         :geolocation, :coverage_areas, :attributes, :listing_source, :variations, :status, :sub_status,
         :tags, :warranty, :catalog_product_id, :parent_item_id, :differential_pricing, :deal_ids,
         :automatic_relist, :date_created, :last_updated, :seller, :installments, :address,
        ]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'pictures'
            self.pictures = v.map { |x| ItemPicture.new(x) } unless v.nil?
          elsif k.to_s == 'descriptions'
            self.descriptions = v.map { |x| ItemDescription.new(x) } unless v.nil?
          elsif k.to_s == 'non_mercado_pago_payment_methods'
            self.non_mercado_pago_payment_methods = v.map { |x| ItemPaymentMethod.new(x) } unless v.nil?
          elsif k.to_s == 'shipping'
            self.shipping = ItemShipping.new(v)
          elsif k.to_s == 'seller_address'
            self.seller_address = Address.new(v)
          elsif k.to_s == 'geolocation'
            self.geolocation = Geolocation.new(v)
          elsif k.to_s == 'seller'
            self.seller = User.new(v)

            if seller.id.present?
              self.seller_id = seller.id
            end
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
