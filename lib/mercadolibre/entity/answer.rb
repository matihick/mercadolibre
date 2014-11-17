module Mercadolibre
  module Entity
    class Answer
      def self.attr_list
        [:text, :status, :date_created]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'date_created'
            self.date_created = Time.parse(v) unless v.nil?
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
