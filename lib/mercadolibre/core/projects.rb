module Mercadolibre
  module Core
    module Projects
      def get_user_project(project_id)
        get_request("/projects/#{project_id}", { access_token: @access_token }).body
      end

      def create_user_project(attrs)
        payload = attrs.to_json

        headers = { content_type: :json }

        post_request("/projects?access_token=#{@access_token}", payload, headers).body
      end

      def update_user_project(project_id, attrs)
        payload = attrs.to_json

        headers = { content_type: :json }

        put_request("/projects/#{project_id}?access_token=#{@access_token}", payload, headers).body
      end

      def delete_user_project(project_id)
        delete_request("/projects/#{project_id}?access_token=#{@access_token}").body
      end

      def add_application_to_project(application_id, project_id)
        payload = { application_id: application_id }.to_json

        headers = { content_type: :json }

        post_request("/projects/#{project_id}/applications?access_token=#{@access_token}",
          payload, headers).body
      end

      def remove_application_from_project(application_id, project_id)
        delete_request("/projects/#{project_id}/applications/#{application_id}?access_token=#{@access_token}").body
      end
    end
  end
end
