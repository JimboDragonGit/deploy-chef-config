
module YP
  def chef_user
    ENV['USER'].nil? ? 'root' : ENV['USER']
  end

  def chefrepo_path
    repository_folder(project_name)
  end

  def cookbooks_path
    ::File.join(chefrepo_path, 'cookbooks')
  end

  def profile_path
    ::File.join(chefrepo_path, 'profiles.d', chef_user)
  end

  def environment_file
    ::File.join(::File.join(profile_path, 'env.rb'))
  end

  def certs_folder
    ::File.join(chefrepo_path, 'certs')
  end

  def private_certs_folder
    ::File.join(certs_folder, 'private')
  end

  def ssh_certs_folder
    ::File.join(certs_folder, 'ssh')
  end

  def public_certs_folder
    ::File.join(certs_folder, 'public')
  end

  def chef_validator_key
    ::File.join(certs_folder, 'chef', 'jimbodragon-validator.pem')
  end

  def exclude_cookbook
    ['.', '..', 'exemple', 'README.md']
  end
end
