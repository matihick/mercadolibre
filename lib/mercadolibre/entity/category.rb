module Mercadolibre
  module Entity
    class Category
      def self.attr_list
        [:id, :name, :picture, :permalink, :total_items_in_this_category,
         :path_from_root, :children_categories, :attribute_types, :settings]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if ['path_from_root', 'children_categories'].include?(k.to_s)
            self.state = v.map { |x| Category.new(x) }
          elsif k.to_s == 'settings'
            self.settings = CategorySettings.new(v)
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
