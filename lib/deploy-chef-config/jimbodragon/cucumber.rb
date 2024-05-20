module YP
  def cucumber(features = [])
    cmd = ['/opt/chef-workstation/bin/chef exec cucumber']
    cmd << features unless features.empty?
    cmd
  end

  def test_feature_name(feature_name = nil, sudo = false)
    test_feature(["--name '#{feature_name}'"], sudo)
  end

  def test_feature_tag(feature_tag = nil, sudo = false)
    test_feature(["--tag @#{feature_tag}"], sudo)
  end

  def test_feature(features = nil, sudo = false)
    debug_log "Test features#{sudo ? '' : ' as sudo' } #{features} if features file exist #{::File.exist?('features')} in folder #{::Dir.pwd}"
    feature_cmd = if sudo
      sudo_command(cucumber) << features
    else
      cucumber << features
    end
    execute_command(feature_cmd)
  end
end
