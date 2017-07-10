module Mercadolibre
  module Core
    module Listings
      def get_sites
        get_request('/sites').body
      end

      def get_site(site_id)
        get_request("/sites/#{site_id}").body
      end

      def get_site_domain(domain)
        get_request("/site_domains/#{domain}").body
      end

      def get_site_payment_methods(site_id)
        results = get_request("/sites/#{site_id}/payment_methods")
        results.body
      end

      def get_site_payment_method_info(site_id, payment_method_id)
        results = get_request("/sites/#{site_id}/payment_methods/#{payment_method_id}")
        results.body
      end

      def get_listing_types(site_id)
        get_request("/sites/#{site_id}/listing_types").body
      end

      def get_listing_exposures(site_id)
        get_request("/sites/#{site_id}/listing_exposures").body
      end

      def get_listing_prices(site_id, args)
        get_request("/sites/#{site_id}/listing_prices", args).body
      end

      def get_listing_type(site_id, listing_type_id)
        get_request("/sites/#{site_id}/listing_types/#{listing_type_id}").body
      end
    end
  end
end
