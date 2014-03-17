module Mercadolibre
  module Entity
    class ListingPrice
      def self.attr_list
        [:listing_type_id, :listing_type_name, :listing_exposure, :requires_picture,
         :currency_id, :listing_fee_amount, :sale_fee_amount, :free_relist, :stop_time]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'stop_time'
            self.stop_time = Time.parse(v)
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
