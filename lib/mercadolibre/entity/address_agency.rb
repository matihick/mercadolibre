module Mercadolibre
  module Entity
    class AddressAgency
      def self.attr_list
        [:carrier_id, :agency_id, :description, :phone, :open_hours]
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
