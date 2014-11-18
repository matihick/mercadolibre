module Mercadolibre
  module Entity
    class OrderNote
      def self.attr_list
        [:id, :date_created, :date_last_updated, :note]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if ['date_created', 'date_last_updated'].include?(k.to_s)
            self.send("#{k}=", Time.parse(v)) unless v.nil?
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
