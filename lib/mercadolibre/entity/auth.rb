module Mercadolibre
  module Entity
    class Auth
      def self.attr_list
        [:access_token, :refresh_token, :expired_at]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |attr, val|
          self.send("#{attr}=", val)
        end
      end

      private

      attr_writer *attr_list
    end
  end
end
