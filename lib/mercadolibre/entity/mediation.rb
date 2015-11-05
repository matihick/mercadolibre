module Mercadolibre
  module Entity
    class Mediation
      def self.attr_list
        [:id, :status, :interactions]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'interactions'
            self.interactions = MediationInteraction.new(v) unless v.nil?
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
