module Mercadolibre
  module Entity
    class Question
      def self.attr_list
        [:date_created, :item_id, :seller_id, :status, :text,
        :id, :deleted_from_listing, :hold, :answer, :user_id]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'answer'
            self.answer = Answer.new(v) unless v.nil?
          elsif k.to_s == 'from'
            self.user_id = v['id'] unless v.nil?
          elsif k.to_s == 'date_created'
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
