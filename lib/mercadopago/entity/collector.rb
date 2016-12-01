module Mercadopago
  module Entity
    class Collector
      def self.attr_list
        [:id, :first_name, :phone, :email, :nickname, :identification, :last_name]
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


