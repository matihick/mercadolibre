module Mercadolibre
  module Core
    module Collections
      def get_collection(collection_id)
        filters = { access_token: @access_token }
        get_request("/collections/#{collection_id}", filters).body
      end
    end
  end
end
