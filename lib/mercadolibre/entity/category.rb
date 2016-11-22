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
          case k.to_s
          when 'path_from_root'
            self.path_from_root = v.map { |x| Category.new(x) } unless v.nil?
          when 'children_categories'
            self.children_categories = v.map { |x| Category.new(x) } unless v.nil?
          when 'settings'
            self.settings = CategorySettings.new(v) unless v.nil?
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
