module Mercadolibre
  module Core
    module LocationsAndCurrencies
      def get_countries
        get_request('/countries').body
      end

      def get_country(country_id)
        get_request("/countries/#{country_id}").body
      end

      def get_state(state_id)
        get_request("/states/#{state_id}").body
      end

      def get_city(city_id)
        get_request("/cities/#{city_id}").body
      end

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

      def get_zip_code_info(country_id, zip_code)
        get_request("/countries/#{country_id}/zip_codes/#{zip_code}").body
      end
    end
  end
end
