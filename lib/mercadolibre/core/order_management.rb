module Mercadolibre
  module Core
    module OrderManagement
      def get_all_orders(filters={})
        filters.merge!({
          seller: get_my_user.id,
          access_token: @access_token,
          limit: 50
        })

        results = []

        kind = filters.delete(:kind)

        if kind.to_s == 'recent'
          orders_urls = ['/orders/search/recent']
        elsif kind.to_s == 'archived'
          orders_urls = ['/orders/search/archived']
        else
          orders_urls = ['/orders/search/recent', '/orders/search/archived']
        end

        orders_urls.each do |orders_url|
          has_results = true
          filters[:offset] = 0
          pages_remaining = filters[:pages_count] || -1

          while (has_results && (pages_remaining != 0)) do
            partial_results = get_request(orders_url, filters)[:body]['results']

            results += partial_results.map { |r| Mercadolibre::Entity::Order.new(r) }

            has_results = partial_results.any?
            filters[:offset] += 50
            pages_remaining -= 1
          end
        end

        results
      end

      def get_orders(kind, filters={})
        filters.merge!({
          seller: get_my_user.id,
          access_token: @access_token
        })

        if kind.to_s == 'archived'
          url = '/orders/search/archived'
        else
          url = '/orders/search/recent'
        end

        response = get_request(url, filters)[:body]

        {
          results: response['results'].map { |r| Mercadolibre::Entity::Order.new(r) },
          paging: response['paging']
        }
      end

      def get_order(order_id)
        filters = { access_token: @access_token }
        r = get_request("/orders/#{order_id}", filters)

        Mercadolibre::Entity::Order.new(r[:body])
      end

      def get_order_notes(order_id)
        filters = { access_token: @access_token }
        results = get_request("/orders/#{order_id}/notes", filters)

        results[:body].first['results'].map { |r| Mercadolibre::Entity::OrderNote.new(r) }
      end

      def create_order_note(order_id, text)
        payload = { note: text }.to_json

        headers = { content_type: :json, accept: :json }

        result = post_request("/orders/#{order_id}/notes?access_token=#{@access_token}", payload, headers)

        Mercadolibre::Entity::OrderNote.new(result[:body]['note'])
      end

      def update_order_note(order_id, note_id, text)
        payload = { note: text }.to_json

        headers = { content_type: :json, accept: :json }

        result = put_request("/orders/#{order_id}/notes/#{note_id}?access_token=#{@access_token}", payload, headers)

        Mercadolibre::Entity::OrderNote.new(result[:body]['note'])
      end

      def delete_order_note(order_id, note_id)
        result = delete_request("/orders/#{order_id}/notes/#{note_id}?access_token=#{@access_token}")

        result[:status_code] == 200
      end

      def get_order_feedbacks(order_id)
        filters = { access_token: @access_token }

        result = get_request("/orders/#{order_id}/feedback", filters)[:body]

        if result['sale']
          sale_feedback = Mercadolibre::Entity::Feedback.new(result['sale'])
        else
          sale_feedback = nil
        end

        if result['purchase']
          purchase_feedback = Mercadolibre::Entity::Feedback.new(result['purchase'])
        else
          purchase_feedback = nil
        end

        { seller: sale_feedback, buyer: purchase_feedback }
      end

      def get_buyer_feedback(order_id)
        result = get_request("/orders/#{order_id}/feedback/purchase?access_token=#{@access_token}")

        Mercadolibre::Entity::Feedback.new(result[:body])
      end

      def get_seller_feedback(order_id)
        result = get_request("/orders/#{order_id}/feedback/sale?access_token=#{@access_token}")

        Mercadolibre::Entity::Feedback.new(result[:body])
      end

      def give_feedback_to_order(order_id, feedback_data)
        payload = feedback_data.to_json

        headers = { content_type: :json }

        post_request("/orders/#{order_id}/feedback?access_token=#{@access_token}", payload, headers)[:body]
      end

      def change_feedback_from_order(order_id, kind, feedback_data)
        payload = feedback_data.to_json

        headers = { content_type: :json }

        if kind.to_s == 'buyer'
          put_request("/orders/#{order_id}/feedback/purchase?access_token=#{@access_token}", payload, headers)[:body]
        elsif kind.to_s == 'seller'
          put_request("/orders/#{order_id}/feedback/sale?access_token=#{@access_token}", payload, headers)[:body]
        else
          raise 'invalid kind'
        end
      end

      def reply_feedback(order_id, kind, text)
        payload = { reply: text }.to_json

        headers = { content_type: :json }

        if kind.to_s == 'buyer'
          post_request("/orders/#{order_id}/feedback/purchase?access_token=#{@access_token}", payload, headers)[:body]
        elsif kind.to_s == 'seller'
          post_request("/orders/#{order_id}/feedback/sale?access_token=#{@access_token}", payload, headers)[:body]
        else
          raise 'invalid kind'
        end
      end

      def get_site_payment_methods(site_id)
        results = get_request("/sites/#{site_id}/payment_methods")

        results[:body].map { |r| Mercadolibre::Entity::PaymentMethod.new(r) }
      end

      def get_site_payment_method_info(site_id, payment_method_id)
        results = get_request("/sites/#{site_id}/payment_methods/#{payment_method_id}")

        Mercadolibre::Entity::PaymentMethod.new(results[:body])
      end

      def get_order_blacklist(user_id)
        results = get_request("/users/#{user_id}/order_blacklist?access_token=#{@access_token}")

        results[:body].map { |r| Mercadolibre::Entity::User.new(r) }
      end
    end
  end
end
