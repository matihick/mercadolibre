module Mercadolibre
  module Core
    module Metrics
      def get_user_visits(user_id, args={})
        get_request("/users/#{user_id}/items_visits", args).body
      end

      def get_user_visits_tw(user_id, args={})
        get_request("/users/#{user_id}/items_visits/time_window", args).body
      end

      def get_user_question_quantities(user_id, args={})
        get_request("/users/#{user_id}/contacts/questions", args).body
      end

      def get_user_question_quantities_tw(user_id, args={})
        get_request("/users/#{user_id}/contacts/questions/time_window", args).body
      end

      def get_user_see_phone_clicked_quantities(user_id, args={})
        get_request("/users/#{user_id}/contacts/phone_views", args).body
      end

      def get_user_see_phone_clicked_quantities_tw(user_id, args={})
        get_request("/users/#{user_id}/contacts/phone_views/time_window", args).body
      end

      def get_items_visits(item_ids, args={})
        item_ids_desc = (item_ids.is_a?(Array) ? item_ids.join(',') : item_ids)
        get_request("/items/visits", args.merge(ids: item_ids_desc)).body
      end

      def get_item_visits_tw(item_id, args={})
        get_request("/items/#{item_id}/visits/time_window", args).body
      end

      def get_total_items_visits(item_ids)
        if item_ids.is_a? Array
          result = { }

          item_ids.each_slice(50) do |ids_group|
            filters = { ids: ids_group.join(',') }
            result.merge!(get_request('/visits/items', filters, { api_response_kind: 'hash' }).body)
          end

          result
        else
          filters = { ids: ids_group.join(',') }
          get_request('/visits/items', filters, { api_response_kind: 'hash' }).body[item_ids]
        end
      end

      def get_user_items_see_phone_clicked_quantities_tw(item_ids, args)
        item_ids_desc = (item_ids.is_a?(Array) ? item_ids.join(',') : item_ids)
        get_request("/items/contacts/phone_views/time_window", args.merge(ids: item_ids_desc)).body
      end
    end
  end
end
