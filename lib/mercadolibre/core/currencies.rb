module Mercadolibre
  module Core
    module Currencies
      def get_currencies
        get_request('/currencies').body
      end

      def get_currency(currency_id)
        get_request("/currencies/#{currency_id}").body
      end

      def currency_convertion_rate(currency_from, currency_to)
        filters = { from: currency_from, to: currency_to }
        get_request('/currency_conversions/search', filters).body
      end
    end
  end
end
