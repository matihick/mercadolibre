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

      def get_user_accepted_payment_methods(user_id)
        results = get_request("/users/#{user_id}/accepted_payment_methods")

        results[:body].map { |r| Mercadolibre::Entity::PaymentMethod.new(r) }
      end
    end
  end
end
