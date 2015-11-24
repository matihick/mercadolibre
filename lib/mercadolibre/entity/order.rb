module Mercadolibre
  module Entity
    class Order
      def self.attr_list
        [:id, :status, :status_detail, :date_created, :date_closed, :last_updated,
        :order_items, :currency_id, :buyer, :seller, :payments, :feedback, :shipping,
        :tags, :mediations, :comments, :expiration_date, :coupon, :total_amount,
        :total_amount_with_shipping, :paid_amount]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'order_items'
            self.order_items = v.map { |x| OrderItem.new(x) } unless v.nil?
          elsif k.to_s == 'payments'
            self.payments = v.map { |x| Payment.new(x) } unless v.nil?
          elsif k.to_s == 'feedback'
            self.feedback = OrderFeedback.new(v) unless v.nil?
          elsif k.to_s == 'shipping'
            self.shipping = OrderShipping.new(v) unless v.nil?
          elsif k.to_s == 'coupon'
            self.coupon = OrderCoupon.new(v) unless v.nil?
          elsif ['buyer', 'seller'].include?(k.to_s)
            self.send("#{k}=", User.new(v)) unless v.nil?
          elsif k.to_s == 'mediations'
            self.mediations = v.map { |x| Mediation.new(x) } unless v.nil?
          elsif ['date_created', 'date_closed', 'last_updated', 'expiration_date'].include?(k.to_s)
            self.send("#{k}=", Time.parse(v)) unless v.nil?
          else
            self.send("#{k}=", v) if self.respond_to?(k)
          end
        end

        self.last_updated = date_created if last_updated.nil?
      end

      private

      attr_writer *attr_list
    end
  end
end
