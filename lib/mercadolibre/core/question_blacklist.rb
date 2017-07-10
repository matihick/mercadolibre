module Mercadolibre
  module Core
    module QuestionBlacklist
      def get_questions_blacklist(seller_id, args)
        result = get_request("/users/#{seller_id}/questions_blacklist", args.merge({
          access_token: @access_token
        })).body
      end

      def add_user_to_questions_blacklist(seller_id, user_id)
        payload = { user_id: user_id }.to_json

        headers = { content_type: :json }

        url = "/users/#{seller_id}/questions_blacklist?access_token=#{@access_token}"

        post_request(url, payload, headers).status_code == 200
      end

      def remove_user_from_questions_blacklist(seller_id, user_id)
        url = "/users/#{seller_id}/questions_blacklist/#{user_id}?access_token=#{@access_token}"

        delete_request(url).status_code == 200
      end
    end
  end
end
