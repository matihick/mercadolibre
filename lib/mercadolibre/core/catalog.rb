module Mercadolibre
  module Core
    module Catalog
      def get_item_catalog_elegibility(item_id)
        attrs = { access_token: @access_token }
        get_request("/items/#{item_id}/catalog_listing_eligibility", attrs).body
      end
    end
  end
end
