module Mercadolibre
  module Core
    module CategoriesAndListings
      def get_sites
        results = get_request('/sites')

        results[:body].map { |r| Mercadolibre::Entity::Site.new(r) }
      end

      def get_site(site_id)
        result = get_request("/sites/#{site_id}")

        Mercadolibre::Entity::Site.new(result[:body])
      end

      def get_site_domain_info(domain)
        result = get_request("/site_domains/#{domain}")

        Mercadolibre::Entity::SiteDomain.new(result[:body])
      end

      def get_site_categories(site_id)
        results = get_request("/sites/#{site_id}/categories")

        results[:body].map { |r| Mercadolibre::Entity::Category.new(r) }
      end

      def get_site_categories(site_id)
        results = get_request("/sites/#{site_id}/categories")

        results[:body].map { |r| Mercadolibre::Entity::Category.new(r) }
      end
    end
  end
end

