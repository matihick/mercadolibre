module Mercadolibre
  module Entity
    class City
      def self.attr_list
        [:id, :name, :state, :country]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'state'
            self.state = State.new(v)
          elsif k.to_s == 'country'
            self.country = Country.new(v)
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
