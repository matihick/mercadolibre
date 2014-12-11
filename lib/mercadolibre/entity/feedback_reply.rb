module Mercadolibre
  module Entity
    class FeedbackReply
      def self.attr_list
        [:message, :reply_date, :reply_status]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'reply_date'
            self.reply_date = Time.parse(v) unless v.nil?
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
