module Mercadolibre
  module Entity
    class Feedback
      def self.attr_list
        [:rating, :date_created, :fulfilled, :reason, :message, :reply]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'date_created'
            self.date_created = Time.parse(v)
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
