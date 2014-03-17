module Mercadolibre
  module Entity
    class ItemDescription
      def self.attr_list
        [:id, :created, :text, :plain_text]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'created'
            self.created = Time.parse(v) unless v.nil?
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
