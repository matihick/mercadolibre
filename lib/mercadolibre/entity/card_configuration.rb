module Mercadolibre
  module Entity
    class CardConfiguration
      def self.attr_list
        [:bin_card_pattern, :bin_card_exclusion_pattern, :card_number_length,
         :security_code_length, :luhn_algorithm, :installment_bins_pattern,
         :additional_info_needed]
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
