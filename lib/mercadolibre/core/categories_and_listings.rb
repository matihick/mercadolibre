module Mercadolibre
  module Core
    module CategoriesAndListings
      def get_sites
        get_request('/sites').body
      end

      def get_site(site_id)
        get_request("/sites/#{site_id}").body
      end

      def get_site_domain_info(domain)
        get_request("/site_domains/#{domain}").body
      end

      def get_listing_types(site_id)
        get_request("/sites/#{site_id}/listing_types").body
      end

      def get_listing_exposures(site_id)
        get_request("/sites/#{site_id}/listing_exposures").body
      end

      def get_listing_prices(filters)
        valid_filters = ['price', 'listing_type_id', 'quantity', 'category_id', 'currency_id']
        filters.keep_if { |k,v| valid_filters.include?(k.to_s) }

        get_request("/sites/#{site_id}/listing_prices", filters).body
      end

      def get_site_categories(site_id)
        get_request("/sites/#{site_id}/categories").body
      end

      def get_category(category_id)
        get_request("/categories/#{category_id}").body
      end
    end
  end
end

