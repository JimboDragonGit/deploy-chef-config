module JimboDragon
  def windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def mac?
    (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  def unix?
    !windows?
  end

  def linux?
    unix? and not OS.mac?
  end

  def jruby?
    RUBY_ENGINE == 'jruby'
  end

  def jimbodragon_date
    get_data(windows? ? 'powershell get-date -Format "yyyy-MM-ddTHH:mm:sszzz"' : 'date +%FT%T%:z')
  end

  def jimbodragon_null
    windows? ? 'nul' : '/dev/null'
  end
end
