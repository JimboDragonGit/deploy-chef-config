module JimboDragon
  def chef_version(gem_name)
  end

  def chef_client(options = [])
    execute_command(sudo_command([windows? ? 'chef-client' : '/opt/chef-workstation/bin/chef-client'] << options))
  end

  def create_data_bag(data_bag_name)
    execute_command(['knife data bag create', data_bag_name])
  end

  def set_secret_data_bag(data_bag, json_file, secret_file)
    execute_command(['knife data bag from_file', data_bag, json_file, "--encrypt --secret-file #{secret_file}"])
  end

  def get_data_bag_object(data_bag, item)
    JSON.parse(get_data("knife data bag show --format json #{data_bag} #{item}"))
  end

  def get_secret_data_bag_object(data_bag, item, secret_file)
    debug_log "Fetching secret data bag #{data_bag}::#{item} with file #{secret_file}"
    JSON.parse(get_data("knife data bag show --format json --secret-file #{secret_file} --encrypt #{data_bag} #{item}"))
  end
end
