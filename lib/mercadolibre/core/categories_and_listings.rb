module Mercadolibre
  module Core
    module CategoriesAndListings
      def get_sites
        get_request('/sites').body
      end

      def get_site(site_id=nil)
        get_request("/sites/#{site_id}").body
      end

      def get_site_domain_info(domain)
        get_request("/site_domains/#{domain}").body
      end

      def get_listing_types(site_id=nil)
        site_id = @site if site_id.nil?
        get_request("/sites/#{site_id}/listing_types").body
      end

      def get_listing_exposures(site_id=nil)
        site_id = @site if site_id.nil?
        get_request("/sites/#{site_id}/listing_exposures").body
      end

      def get_listing_prices(filters={})
        get_request("/sites/#{site_id}/listing_prices", filters).body
      end

      def get_site_categories(site_id=nil)
        site_id = @site if site_id.nil?
        get_request("/sites/#{site_id}/categories").body
      end

      def get_site_category(category_id)
        get_request("/categories/#{category_id}").body
      end

      def get_category_attributes(category_id)
        get_request("/categories/#{category_id}/attributes").body
      end

      def get_category_prediction(title, site_id=nil)
        site_id = @site if site_id.nil?
        get_request("/sites/#{site_id}/category_predictor/predict", { title: title }).body
      end

      def get_category_promotion_packs(category_id)
        get_request("/categories/#{category_id}/classifieds_promotion_packs").body
      end

      def get_listing_type(listing_type_id, site_id=nil)
        site_id = @site if site_id.nil?
        get_request("/sites/#{site_id}/listing_types/#{listing_type_id}", { title: title }).body
      end
    end
  end
end

