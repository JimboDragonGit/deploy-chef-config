
module JimboDragon
  def create_self_signed_gem_certificate
    ::FileUtils.mkdir(::File.join(ENV['HOME'], '.gem')) unless ::File.join(ENV['HOME'], '.gem')
    unless rubygem_private_key_exist?
      execute_command(["chef gem cert --build", rubygems_user])
      FileUtils.mv('gem-private_key.pem', rubygem_private_key)
      FileUtils.mv('gem-private_key.pem', rubygem_public_key)
      execute_command(["chmod 0600", rubygem_private_key, rubygem_public_key]) if unix?
    end
  end
end
