module JimboDragon
  def main_folder
    ENV['HOME']
  end

  def repository_folder(repository)
    ::File.join(main_folder, repository)
  end

  def git_commit_message(repository)
    "Committing #{repository} as automatic action"
  end

  def repository_exist?(repository)
    ::File.exist?(repository_folder(repository))
  end

  def github_clone_command(organisation, repository)
    "chef exec git clone #{get_github_repository(organisation, repository)}"
  end

  def get_github_repository(organisation, repository)
    "git@github.com:#{organisation}/#{repository}.git"
  end

  def github_initialise(organisation, repository)
    Dir.chdir ::File.dirname(repository_folder(repository))
    execute_command([github_clone_command]) unless repository_exist?(repository)
    Dir.chdir repository_folder(repository)
  end

  def git_sync(repository)
    Dir.chdir repository_folder(repository)
    log "Fetching #{repository}"
    execute_command(["chef exec git fetch"])
    log "Pulling #{repository}"
    execute_command(["chef exec git pull"])
  end

  def git_update(repository)
    Dir.chdir repository_folder(repository)
    log "Adding #{repository}"
    execute_command(["chef exec git add ."])
    log "Committing #{repository}"
    execute_command(["chef exec git commit -m '", git_commit_message(repository), "'"])
    log "Pushing #{repository}"
    execute_command(["chef exec git push"])
  end
end
