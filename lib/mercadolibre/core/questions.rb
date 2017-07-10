module Mercadolibre
  module Core
    module Questions
      def search_questions(filters={})
        if @access_token.present?
          filters.merge!({ access_token: @access_token })
        end

        get_request('/questions/search', filters).body
      end

      def search_questions_total(filters={})
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

        post_request("/questions/#{item_id}?access_token=#{@access_token}", payload, headers).body
      end

      def answer_question(question_id, text)
        payload = { question_id: question_id, text: text }.to_json

        headers = { content_type: :json, accept: :json }

        post_request("/answers?access_token=#{@access_token}", payload, headers).body
      end

      def search_my_questions(filters={})
        filters.merge!({ access_token: @access_token })

        get_request('/my/received_questions/search', filters).body
      end

      def search_my_questions_total(filters={})
        filters.merge!({ access_token: @access_token, limit: 1, offset: 0 })
        get_request('/my/received_questions/search', filters).body.total.to_i
      end
    end
  end
end
