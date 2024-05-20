module Context
  module DeployHelpers
    module EnvironmentHelper
      attr_reader :context_config

      def validate_environment(context, name)
        context.debug_log "Validate environment #{name}"
        environment_data = context.send(name)
        context.debug_log "Environment Variable #{name} is #{environment_data}"
        environment_data
      end

      def random_secret
        SecureRandom.base64(12)
      end

      def random_encrypted_secret
        UnixCrypt::SHA512.build(random_secret)
      end

      def temp_env_json(context, variable_type)
        ::File.join(context.temp_dir, "#{ENV[get_variable_id(variable_type)]}.jimbodragon_env.json")
      end

      def register_json_environments(context, variable_type)
        context.log "Register environment variables #{ENV.inspect}"
        ::File.write(temp_env_json(variable_type), JSON.pretty_generate({"id": ENV[get_variable_id(variable_type)]}.merge(environtment_to_json)))
      end

      def get_variable_id(context, variable_type)
        case variable_type
        when 'machine'
          context.windows? ? 'COMPUTERNAME' : 'HOSTNAME'
        else
          'USER'
        end
      end

      def get_hostname(context)
        ENV[context.get_variable_id(context, 'machine')]
      end

      def environtment_to_json(context)
        environment_file = Hash.new
        %w(
          jimbodragon_node_name
          jimbodragon_node_key_file
          jimbodragon_chef_server_url
          jimbodragon_secret
          jimbodragon_editor
          github_ssh_private_key_file
          github_ssh_public_key_file
          github_ssh_private_key
          github_ssh_public_key
          jimbodragon_node_key
          jimbodragon_named_run_list
          jimbodragon_validation_key_file
          jimbodragon_validation_key
          rubygem_private_key_file
          rubygem_public_key_file
          rubygem_private_key
          rubygem_public_key
          rubygem_trust_key_file
          rubygem_trust_key
          jimbodragon_context_data_bag
          jimbodragon_secret_file
          rubygems_api_key
          hab_auth_token
          hab_origin
          hab_license
          do_check
          cucumber_publish_enabled
          cucumber_publish_quiet
          cucumber_publish_token
          circleci_token
          circleci_api_token
          circleci_org_optin
          aws_access_key_id
          aws_secret_access_key
          dockerhub_user
          dockerhub_password
          docker_user
          docker_pass
        ).each do |variable|
          environment_file[variable] = context.validate_environment(context, variable)
        end
        environment_file
      end
    end
  end
end
