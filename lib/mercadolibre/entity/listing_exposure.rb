module Mercadolibre
  module Entity
    class ListingExposure
      def self.attr_list
        [:id, :name, :home_page, :category_home_page, :advertising_on_listing_page, :priority_in_search]
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
