module Mercadolibre
  module Core
    module Users
      def get_my_user
        get_request('/users/me', { access_token: @access_token }).body
      end

      def get_user(user_id)
        get_request("/users/#{user_id}").body
      end

      def get_users(user_ids)
        get_request('/users', { ids: user_ids.join(',') }).body
      end

      def get_seller(nickname)
        filters = { nickname: nickname, limit: 0 }
        response = get_request("/sites/#{@site}/search", filters)[:body]
        get_user(response.seller.id)
      end

      def get_user_accepted_payment_methods(user_id)
        get_request("/users/#{user_id}/accepted_payment_methods").body
      end
    end
  end
end
