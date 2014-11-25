module Mercadolibre
  module Entity
    class OrderFeedback
      def self.attr_list
        [:sale, :purchase]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        if attributes['sale'].present?
          self.sale = Feedback.new(attributes['sale'])
        end

        if attributes['purchase'].present?
          self.purchase = Feedback.new(attributes['purchase'])
        end
      end

      private

      attr_writer *attr_list
    end
  end
end
