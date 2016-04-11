module Mercadolibre
  module Entity
    class ItemDescription
      def self.attr_list
        [:id, :created, :last_updated, :date_created, :text, :plain_text]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        time_attrs = ['created', 'date_created', 'last_updated']

        attributes.each do |k, v|
          if time_attrs.include?(k.to_s)
            self.send("#{k}=", Time.parse(v))  unless v.nil?
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
