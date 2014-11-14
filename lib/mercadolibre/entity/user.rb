module Mercadolibre
  module Entity
    class User
      def self.attr_list
        [:id, :nickname, :registration_date, :first_name, :last_name, :blocked,
        :country_id, :email, :user_type, :points, :site_id, :permalink, :phone,
        :alternative_phone, :billing_info]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'registration_date'
            self.registration_date = Time.parse(v)
          elsif k.to_s == 'phone'
            self.phone = Phone.new(v)
          elsif k.to_s == 'alternative_phone'
            self.alternative_phone = Phone.new(v)
          elsif k.to_s == 'billing_info'
            self.billing_info = BillingInfo.new(v)
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
