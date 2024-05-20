module JimboDragon
  def secret_file_present?
    ::File.exist? jimbodragon_secret_file
  end

  def set_secret_file
    ::File.write(jimbodragon_secret_file, jimbodragon_secret)
  end

  def load_secret_file
    @jimbodragon_secret = ::File.read(jimbodragon_secret_file)
  end

  def check_secret_file(fail_if_error = false)
    if secret_file_present?
      log "Secret file #{jimbodragon_secret_file} is present"
    else
      log "Secret file #{jimbodragon_secret_file} is missing"
      exit context_missing_error if fail_if_error
    end
  end
end
