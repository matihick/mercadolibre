module Mercadolibre
  module Entity
    class CategorySettings
      def self.attr_list
        [:adult_content, :buying_allowed, :buying_modes, :coverage_areas, :currencies,
         :fragile, :immediate_payment, :item_conditions, :items_reviews_allowed, :listing_allowed,
         :max_description_length, :max_pictures_per_item, :max_sub_title_length, :max_title_length,
         :maximum_price, :minimum_price, :mirror_category, :price, :restrictions, :rounded_address,
         :seller_contact, :shipping_modes, :shipping_options, :shipping_profile,
         :show_contact_information, :simple_shipping, :stock, :tags, :vip_subdomain]
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
