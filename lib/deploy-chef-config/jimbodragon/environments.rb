module JimboDragon
  attr_reader :context_config

  def environment_data(name)
    context_config = JimboDragon::Context::ContextConfig.new if context_config.nil?
    context_config.send(name)
  end

  def validate_environment(name)
    debug_log "Validate environment #{name}"
    environment_data = environment_data(name)
    debug_log "Environment Variable #{name} is #{environment_data}"
    environment_data
  end

  def random_secret
    SecureRandom.base64(12)
  end

  def random_encrypted_secret
    UnixCrypt::SHA512.build(random_secret)
  end

  def user_temp_env_json
    ::File.join(temp_dir, "#{ENV['USER']}.jimbodragon_env.json")
  end

  def register_json_environments(env_file)
    log "Register environment variables #{ENV.inspect}"
    ::File.write(env_file, JSON.pretty_generate(environtment_to_json))
  end

  def validate_environments
    validate_environment('jimbodragon_node_name')
    validate_environment('jimbodragon_node_key_file')
    validate_environment('jimbodragon_chef_server_url')
    validate_environment('jimbodragon_secret')
    validate_environment('jimbodragon_editor')
    validate_environment('github_ssh_private_key_file')
    validate_environment('github_ssh_public_key_file')
    validate_environment('github_ssh_private_key')
    validate_environment('github_ssh_public_key')
    validate_environment('jimbodragon_node_key')
    validate_environment('jimbodragon_named_run_list')
    validate_environment('jimbodragon_validation_key_file')
    validate_environment('jimbodragon_validation_key')
    validate_environment('rubygem_private_key_file')
    validate_environment('rubygem_public_key_file')
    validate_environment('rubygem_private_key')
    validate_environment('rubygem_public_key')
    validate_environment('rubygem_trust_key_file')
    validate_environment('rubygem_trust_key')
    validate_environment('jimbodragon_context_data_bag')
    validate_environment('jimbodragon_secret_file')
    validate_environment('rubygems_api_key')
  end

  def environtment_to_json
    {
      id: ENV['USER'],
      jimbodragon_node_name: ENV['JIMBODRAGON_NODE_NAME'],
      jimbodragon_node_key_file: ENV['JIMBODRAGON_NODE_KEY_FILE'],
      jimbodragon_chef_server_url: ENV['JIMBODRAGON_CHEF_SERVER_URL'],
      jimbodragon_secret: ENV['JIMBODRAGON_SECRET'],
      jimbodragon_editor: ENV['JIMBODRAGON_EDITOR'],
      jimbodragon_context_data_bag: ENV['JIMBODRAGON_CONTEXT_DATA_BAG'],
      github_ssh_private_key_file: ENV['GITHUB_SSH_PRIVATE_KEY_FILE'],
      github_ssh_public_key_file: ENV['GITHUB_SSH_PUBLIC_KEY_FILE'],
      github_ssh_public_key_file: ENV['GITHUB_SSH_PUBLIC_KEY_FILE'],
      github_ssh_private_key: ENV['GITHUB_SSH_PRIVATE_KEY'],
      github_ssh_public_key: ENV['GITHUB_SSH_PUBLIC_KEY'],
      jimbodragon_named_run_list: ENV['JIMBODRAGON_NAMED_RUN_LIST'],
      jimbodragon_validation_key_file: ENV['JIMBODRAGON_VALIDATION_KEY_FILE'],
      jimbodragon_validation_key: ENV['JIMBODRAGON_VALIDATION_KEY'],
      rubygem_private_key_file: ENV['RUBYGEM_PRIVATE_KEY_FILE'],
      rubygem_public_key_file: ENV['RUBYGEM_PUBLIC_KEY_FILE'],
      rubygem_private_key: ENV['RUBYGEM_PRIVATE_KEY'],
      rubygem_public_key: ENV['RUBYGEM_PUBLIC_KEY'],
      rubygem_trust_key_file: ENV['RUBYGEM_TRUST_KEY_FILE'],
      rubygem_trust_key: ENV['RUBYGEM_TRUST_KEY'],
      rubygems_api_key: ENV['RUBYGEMS_API_KEY'],
      hab_auth_token: ENV['HAB_AUTH_TOKEN'],
      hab_origin: ENV['HAB_ORIGIN'],
      hab_license: ENV['HAB_LICENSE'],
      do_check: ENV['DO_CHECK'],
      cucumber_publish_enabled: ENV['CUCUMBER_PUBLISH_ENABLED'],
      cucumber_publish_quiet: ENV['CUCUMBER_PUBLISH_QUIET'],
      cucumber_publish_token: ENV['CUCUMBER_PUBLISH_TOKEN'],
      circleci_token: ENV['CIRCLECI_TOKEN'],
      circleci_api_token: ENV['CIRCLECI_API_TOKEN'],
      circleci_org_optin: ENV['CIRCLECI_ORG_OPTIN'],
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      dockerhub_user: ENV['DOCKERHUB_USER'],
      dockerhub_password: ENV['DOCKERHUB_PASSWORD'],
      docker_user: ENV['DOCKER_USER'],
      docker_pass: ENV['DOCKER_PASS'],
    }
  end
end
