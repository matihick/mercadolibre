module Mercadolibre
  module Core
    module LocationsAndCurrencies
      def get_countries
        results = get_request('/countries')

        results[:body].map { |r| Mercadolibre::Entity::Country.new(r) }
      end

      def get_country(country_id)
        result = get_request("/countries/#{country_id}")

        Mercadolibre::Entity::Country.new(result[:body])
      end

      def get_state(state_id)
        result = get_request("/states/#{state_id}")

        Mercadolibre::Entity::State.new(result[:body])
      end

      def get_city(city_id)
        result = get_request("/cities/#{city_id}")

        Mercadolibre::Entity::City.new(result[:body])
      end

      def get_currencies
        results = get_request('/currencies')

        results[:body].map { |r| Mercadolibre::Entity::Currency.new(r) }
      end

      def get_currency(currency_id)
        result = get_request("/currencies/#{currency_id}")

        Mercadolibre::Entity::Currency.new(result[:body])
      end

      def currency_convertion_rate(currency_from, currency_to)
        filters = { from: currency_from, to: currency_to }
        result = get_request('/currency_conversions/search', filters)

        Mercadolibre::Entity::Currency.new({
          currency_from: currency_from,
          currency_to: currency_to,
          ratio: result[:body]['ratio'],
          mercado_pago_ratio: result[:body]['mercado_pago_ratio']
        })
      end

      def get_zip_code_info(country_id, zip_code)
        result = get_request("/countries/#{country_id}/zip_codes/#{zip_code}")

        Mercadolibre::Entity::ZipCode.new(result[:body])
      end
    end
  end
end
