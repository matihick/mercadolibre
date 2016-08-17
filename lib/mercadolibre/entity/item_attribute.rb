module Mercadolibre
  module Entity
    class ItemAttribute
      def self.attr_list
        [:id, :name, :value_id, :value_name, :attribute_group_id, :attribute_group_name]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          self.send("#{k}=", v) if self.respond_to?(k)
        end
      end

      private

      attr_writer *attr_list
    end
  end
end
