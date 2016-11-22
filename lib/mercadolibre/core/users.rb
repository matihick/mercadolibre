module Mercadolibre
  module Core
    module Users
      def get_my_user
        result = get_request('/users/me', { access_token: @access_token })

        Mercadolibre::Entity::User.new(result[:body])
      end

      def get_user(user_id)
        result = get_request("/users/#{user_id}")

        Mercadolibre::Entity::User.new(result[:body])
      end

      def get_users(user_ids)
        results = get_request('/users', { ids: user_ids.join(',') })

        results[:body].map { |r| Mercadolibre::Entity::User.new(r) }
      end

      def get_seller(nickname)
        filters = { nickname: nickname, limit: 0 }
        response = get_request("/sites/#{@site}/search", filters)[:body]
        get_user(response['seller']['id'])
      end

      def get_user_accepted_payment_methods(user_id)
        results = get_request("/users/#{user_id}/accepted_payment_methods")

        results[:body].map { |r| Mercadolibre::Entity::PaymentMethod.new(r) }
      end

      def revoke_access(user_id)
        headers = { content_type: :json, accept: :json }
        results = delete_request("/users/#{user_id}/applications/#{@app_key}?access_token=#{@access_token}", headers)

        results[:body]
      end
    end
  end
end
