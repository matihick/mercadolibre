module Mercadolibre
  module Entity
    class Address
      def self.attr_list
        [:state, :street_name, :city, :country, :address_line, :id,
         :zip_code, :longitude, :street_number, :latitude, :comment]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'state'
            self.state = State.new(v) unless v.nil?
          elsif k.to_s == 'city'
            self.city = City.new(v) unless v.nil?
          elsif k.to_s == 'country'
            self.country = Country.new(v) unless v.nil?
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
