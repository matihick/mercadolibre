module Mercadolibre
  module Entity
    class OrderFeedback
      def self.attr_list
        [:buyer, :seller]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        self.buyer = Feedback.new(attributes['buyer']) unless attributes['buyer'].nil?
        self.seller = Feedback.new(attributes['seller']) unless attributes['seller'].nil?
      end

      private

      attr_writer *attr_list
    end
  end
end
