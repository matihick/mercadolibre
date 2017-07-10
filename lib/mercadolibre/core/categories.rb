module Mercadolibre
  module Core
    module Categories
      def get_site_categories(site_id)
        get_request("/sites/#{site_id}/categories").body
      end

      def get_category(category_id)
        get_request("/categories/#{category_id}").body
      end

      def get_category_attributes(category_id)
        get_request("/categories/#{category_id}/attributes").body
      end

      def get_category_prediction(site_id, args)
        get_request("/sites/#{site_id}/category_predictor/predict", args).body
      end

      def get_multiple_category_prediction(site_id, categories_data)
        payload = categories_data.to_json

        headers = { content_type: :json }

        post_request("/sites/#{site_id}/category_predictor/predict", payload, headers).body
      end

      def get_category_promotion_packs(category_id)
        get_request("/categories/#{category_id}/classifieds_promotion_packs").body
      end

      def get_all_categories(site_id, args={})
        get_request("/sites/#{site_id}/categories/all", args, { api_response_kind: 'raw' }).body
      end

      def get_site_trends(site_id, category_id=nil)
        if category_id.present?
          params = { category: category_id }
        else
          params = { }
        end

        get_request("/sites/#{site_id}/trends/search", params).body
      end
    end
  end
end
