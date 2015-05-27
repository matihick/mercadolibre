module Mercadolibre
  module Entity
    class ItemShipping
      def self.attr_list
        [:mode, :local_pick_up, :free_shipping, :dimensions, :tags, :methods]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          next if k == 'methods'
          self.send("#{k}=", v) if self.respond_to?(k)
        end
      end

      private

      attr_writer *attr_list
    end
  end
end
