module Mercadolibre
  module Entity
    class SearchLocation
      def self.attr_list
        [:neighborhood, :city, :state]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'state'
            self.state = State.new(v) unless v.nil?
          elsif k.to_s == 'city'
            self.city = City.new(v) unless v.nil?
          elsif k.to_s == 'neighborhood'
            self.neighborhood = Neighborhood.new(v) unless v.nil?
          end
        end
      end

      private

      attr_writer *attr_list
    end
  end
end
