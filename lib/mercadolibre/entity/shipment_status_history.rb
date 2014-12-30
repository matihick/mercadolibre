module Mercadolibre
  module Entity
    class ShipmentStatusHistory
      def self.attr_list
        [:date_handling, :date_shipped, :date_delivered, :date_not_delivered,
         :date_returned, :date_cancelled, :date_ready_to_ship, :date_first_visit]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if self.respond_to?(k)
            self.send("#{k}=", Time.parse(v)) unless v.nil?
          end
        end
      end

      private

      attr_writer *attr_list
    end
  end
end
