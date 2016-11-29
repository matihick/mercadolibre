module Mercadolibre
  module Entity
    class Payer
      def self.attr_list
        [:type, :id, :email, :identification, :phone, :first_name, :last_name, :entity_type]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'identification'
            self.identification = Identification.new(v) unless v.nil?
          elsif k.to_s == 'phone'
            self.phone = Phone.new(v) unless v.nil?
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


