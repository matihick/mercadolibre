module Mercadolibre
  module Entity
    class Order
      def self.attr_list
        [:id, :status, :date_created, :date_closed, :date_last_updated,
        :hidden_for_seller, :currency_id, :order_items, :total_amount, :buyer, :seller,
        :payments, :seller_feedback, :buyer_feedback, :shipping_status, :tags]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'order_items'
            self.order_items = v.map { |x| OrderItem.new(x) }
          elsif k.to_s == 'payments'
            self.payments = v.map { |x| Payment.new(x) }
          elsif k.to_s == 'feedback'
            unless v.nil?
              self.buyer_feedback = Feedback.new(v['purchase']) unless v['purchase'].nil?
              self.seller_feedback = Feedback.new(v['sale']) unless v['sale'].nil?
            end
          elsif k.to_s == 'shipping'
            self.shipping_status = v['status']
          elsif ['buyer', 'seller'].include?(k.to_s)
            self.send("#{k}=", User.new(v)) unless v.nil?
          elsif ['date_created', 'date_closed', 'date_last_updated'].include?(k.to_s)
            self.send("#{k}=", Time.parse(v)) unless v.nil?
          else
            self.send("#{k}=", v) if self.respond_to?(k)
          end
        end

        self.date_last_updated = date_created if date_last_updated.nil?
      end

      private

      attr_writer *attr_list
    end
  end
end
