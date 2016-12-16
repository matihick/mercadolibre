module Mercadolibre
  module Core
    module Questions
      def get_my_questions(filters={})
        filters.merge!({ access_token: @access_token })

        get_request('/my/received_questions/search', filters).body
      end

      def get_my_questions_count(filters={})
        filters.merge!({ access_token: @access_token, limit: 1, offset: 0 })
        get_request('/my/received_questions/search', filters).body.total.to_i
      end

      def get_questions(filters={})
        if @access_token.present?
          filters.merge!({ access_token: @access_token })
        end

        get_request('/questions/search', filters).body
      end

      def get_questions_count(filters={})
        if @access_token.present?
          filters.merge!({ access_token: @access_token })
        end

        filters.merge!({ limit: 1, offset: 0 })

        get_request('/questions/search', filters).body['total'].to_i
      end

      def get_question(question_id)
        filters = { access_token: @access_token }

        get_request("/questions/#{question_id}", filters).body
      end

      def delete_question(question_id)
        result = delete_request("/questions/#{question_id}?access_token=#{@access_token}")

        result
      end

      def ask_question(item_id, text)
        payload = { item_id: item_id, text: text }.to_json

        headers = { content_type: :json }

        post_request("/questions?access_token=#{@access_token}", payload, headers).body
      end

      def answer_question(question_id, text)
        payload = { question_id: question_id, text: text }.to_json

        headers = { content_type: :json, accept: :json }

        post_request("/answers?access_token=#{@access_token}", payload, headers).body
      end

      def get_questions_blacklist(seller_id)
        result = get_request("/users/#{seller_id}/questions_blacklist?access_token=#{@access_token}")
        result.body.map { |r| r.user.id }
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
