module JimboDragon
  def version(repository)
    File.read(::File.join(repository_folder(repository),'VERSION')).strip
  end

  def rubygem_private_key_exist?
    ::File.exist?(rubygem_private_key)
  end

  def rubygem_public_key_exist?
    ::File.exist?(rubygem_public_key)
  end

  def check_rubygem_signature(exit_on_failure = true)
    if rubygem_private_key_exist? && rubygem_public_key_exist?
      log "rubygem est signé "
    else
      log "rubygem n\'est pas signé "
      exit rubygem_not_signed_error if exit_on_failure
    end
  end

  def signin_rubygem
    log "Siginin rubygem for user #{ENV['USER']}"
    [
      ['chef gem signin'],
    ].each do |command|
      execute_command(command)
    end
  end

  def signin_rubygem_host(host)
    log "Siginin host #{host} for user #{ENV['USER']}"
    [
      ["chef gem signin --host", rubygem_signin_host],
    ].each do |command|
      log "signin_rubygem_host = #{command}"
      execute_command(command)
    end
  end

  def create_rubygem_keys
    debug_log "Setting RubyGem Keys #{rubygem_private_key}"
    ::File.write(rubygem_private_key, rubygem_private_key_content) unless rubygem_private_key_exist?
    ::File.write(rubygem_public_key, rubygem_public_key_content) unless rubygem_public_key_exist?
  end

#   def install_rubygem_credentials
#     log 'Installing requirements'
#     # log "Full user data = '#{JSON.pretty_generate yp_config}'"
#
#     log 'Setting SSH Folder'
#     local_ssh_folder = ::File.join(ENV['HOME'],'.gem')
#     ::Dir.mkdir(local_ssh_folder) unless ::Dir.exist?(local_ssh_folder)
#       ssh_config = <<MESSAGE_END
# Host github.com
#   HostName github.com
#   IdentityFile #{ssh_private_key}
#
# Host jimbodragon.qc.to
#   HostName jimbodragon.qc.to
#   IdentityFile #{ssh_private_key}
#   Port 2222
#   VerifyHostKeyDNS=yes
#   StrictHostKeyChecking=no
# MESSAGE_END
#     ::File.write(::File.join(local_ssh_folder, 'config'), ssh_config)
#   end
end
