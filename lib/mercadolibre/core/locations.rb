module Mercadolibre
  module Core
    module Locations
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

      def get_zip_code(country_id, zip_code)
        get_request("/countries/#{country_id}/zip_codes/#{zip_code}").body
      end

      def search_zip_codes(country_id, zip_code_from, zip_code_to)
        get_request("/countries/#{country_id}/zip_codes/search_between", {
          zip_code_from: zip_code_from,
          zip_code_to: zip_code_to
        }).body
      end
    end
  end
end
