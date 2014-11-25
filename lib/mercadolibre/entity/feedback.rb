module Mercadolibre
  module Entity
    class Feedback
      def self.attr_list
        [:to, :has_seller_refunded_money, :status, :reason, :site_id, :date_created, :from,
         :order_id, :modified, :id, :message, :fulfilled, :item, :visibility_date, :reply,
         :role, :app_id, :rating, :restock_item]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if ['date_created', 'visibility_date'].include?(k.to_s)
            self.date_created = Time.parse(v) unless v.nil?
          elsif k.to_s == 'to'
            self.to = User.new(v)
          elsif k.to_s == 'from'
            self.from = User.new(v)
          elsif k.to_s == 'item'
            self.item = Item.new(v)
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
