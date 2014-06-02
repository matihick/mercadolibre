module Mercadolibre
  module Core
    module Questions
      def get_all_questions(filters={})
        filters.merge!({ access_token: @access_token, limit: 50, offset: 0 })

        if filters[:seller_id]
          action = '/questions/search'
        else
          action = '/my/received_questions/search'
        end

        results = []
        has_results = true
        pages_remaining = filters[:pages_count] || -1

        while (has_results && (pages_remaining != 0)) do
          partial_results = get_request(action, filters)[:body]['questions']

          results += partial_results.map { |q| Mercadolibre::Entity::Question.new(q) }

          has_results = partial_results.any?
          filters[:offset] += 50
          pages_remaining -= 1
        end

        results
      end

      def get_questions(filters={})
        filters.merge!({ access_token: @access_token })

        if filters[:seller_id]
          url = '/questions/search'
        else
          url = '/my/received_questions/search'
        end

        response = get_request(url, filters)[:body]

        {
          results: response['questions'].map { |r| Mercadolibre::Entity::Question.new(r) },
          paging: { total: response['total'], limit: response['limit'] }
        }
      end

      def get_questions_count(filters={})
        filters.merge!({ access_token: @access_token, limit: 0, offset: 0 })

        if filters[:seller_id]
          url = '/questions/search'
        else
          url = '/my/received_questions/search'
        end

        get_request(url, filters)[:body]['total'].to_i
      end

      def get_question(question_id)
        filters = { access_token: @access_token }

        result = get_request("/questions/#{question_id}", filters)[:body]

        Mercadolibre::Entity::Question.new(result)
      end

      def delete_question(question_id)
        result = delete_request("/questions/#{question_id}?access_token=#{@access_token}")

        result
      end

      def ask_question(item_id, text)
        payload = { item_id: item_id, text: text }.to_json

        headers = { content_type: :json }

        result = post_request("/questions?access_token=#{@access_token}", payload, headers)

        ::Mercadolibre::Entity::Question.new(result[:body])
      end

      def answer_question(question_id, text)
        payload = { question_id: question_id, text: text }.to_json

        headers = { content_type: :json, accept: :json }

        result = post_request("/answers?access_token=#{@access_token}", payload, headers)

        Mercadolibre::Entity::Question.new(result[:body])
      end

      def get_blacklisted_users_ids(seller_id)
        result = get_request("/users/#{seller_id}/questions_blacklist?access_token=#{@access_token}")
        result[:body].map { |r| r['user']['id'] }
      end

      def add_user_to_blacklist(seller_id, user_id)
        payload = { user_id: user_id }.to_json

        headers = { content_type: :json }

        url = "/users/#{seller_id}/questions_blacklist?access_token=#{@access_token}"

        post_request(url, payload, headers)[:status_code] == 200
      end

      def remove_user_from_blacklist(seller_id, user_id)
        url = "/users/#{seller_id}/questions_blacklist/#{user_id}?access_token=#{@access_token}"

        delete_request(url)[:status_code] == 200
      end
    end
  end
end
