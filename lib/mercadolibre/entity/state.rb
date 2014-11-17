module Mercadolibre
  module Entity
    class State
      def self.attr_list
        [:id, :name, :country, :cities]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'cities'
            self.cities = v.map { |x| City.new(x) } unless v.nil?
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
