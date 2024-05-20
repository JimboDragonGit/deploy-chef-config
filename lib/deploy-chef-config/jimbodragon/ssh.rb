module JimboDragon
  def ssh_private_key_exist?
    ::File.exist?(ssh_private_key)
  end

  def ssh_public_key_exist?
    ::File.exist?(ssh_public_key)
  end

  def ssh_known_hosts
    ::File.join(ENV['HOME'], '.ssh', 'known_hosts')
  end

  def check_if_ssh_key_exist(exit_on_failure = true)
    if ssh_private_key_exist? && ssh_public_key_exist?
      log 'SSH keys are in place'
    else
      log "SSH keys are incorrect: ssh_private_key_exist? = #{ssh_private_key_exist?} :: ssh_public_key_exist? = #{ssh_public_key_exist?}"
      exit ssh_keys_error if exit_on_failure
    end
  end

  def create_ssh_keys
    debug_log "Setting Git Keys #{ssh_private_key}"
    ::File.write(ssh_private_key, ssh_private_key_content) unless ssh_private_key_exist?
    ::File.write(ssh_public_key, ssh_public_key_content) unless ssh_public_key_exist?
  end

  def install_jimbodragon_ssh
    log 'Installing requirements'
    # log "Full user data = '#{JSON.pretty_generate yp_config}'"

    log 'Setting SSH Folder'
    local_ssh_folder = ::File.join(ENV['HOME'],'.ssh')
    ::Dir.mkdir(local_ssh_folder) unless ::Dir.exist?(local_ssh_folder)
      ssh_config = <<MESSAGE_END
Host github.com
  HostName github.com
  IdentityFile #{ssh_private_key}

Host jimbodragon.qc.to
  HostName jimbodragon.qc.to
  IdentityFile #{ssh_private_key}
  Port 2222
  VerifyHostKeyDNS=yes
  StrictHostKeyChecking=no
MESSAGE_END
    ::File.write(::File.join(local_ssh_folder, 'config'), ssh_config)
    system("ssh-keyscan -t rsa -p 22 -H github.com >> #{ssh_known_hosts} 2>#{jimbodragon_null}")
    system("ssh-keyscan -t rsa -p 2222 -H jimbodragon.qc.to >> #{ssh_known_hosts} 2>#{jimbodragon_null}")
  end
end
