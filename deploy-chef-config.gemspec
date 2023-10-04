
require 'git-version-bump'

::Gem::Specification.new do |s|
  s.name          = 'deploy-chef-config'
  s.license       = 'MIT'
  s.authors       = ['Jimmy Provencher']
  s.email         = ['jimbo_dragon@hotmail.com']
  s.homepage      = 'https://github.com/JimboDragonGit/deploy-chef-config'
  s.summary       = 'A auto chef bootstrapper and wrapper cookbook to deploy code and context'
  s.description   = 'Using Chef cookbook style and force any script using it to switch to chef even if it is not install. It will install it tho ;)'


  s.version = GVB.version
  s.date    = GVB.date

  # all_files       = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  # s.files         = all_files.grep(%r!^(exe|libraries|rubocop)/|^.rubocop.yml$!)
  # code_folder = 'libraries/'
  # s.files = %w(README.md LICENSE bin/selfbootstrap libraries/selfbootstrap.rb ) + Dir.glob('libraries/**/*') # + Dir.glob('{bin,lib,certs,test}/**/*')
  # s.require_paths = [code_folder]
  # s.executables   = %w(selfbootstrap)
  # s.bindir        = 'exe'


	s.extra_rdoc_files = ["README.md"]
	s.files = `git ls-files`.split("\n")
  s.executables   = [
    'deploy-chef-config'
  ]

  # s.cert_chain  = [File.expand_path('../jimbodragon/certs/public/jimbodragon.pem')]
  # s.signing_key = File.expand_path('../jimbodragon/certs/private/jimbodragon-gem-private_key.pem') if $PROGRAM_NAME =~ /gem\z/

  s.metadata = {
    # 'source_code_uri' => '/home/git/selfbootstrap.git/',
    'bug_tracker_uri' => 'https://github.com/JimboDragonGit/deploy-chef-config/issues',
    'changelog_uri'   => 'https://github.com/JimboDragonGit/deploy-chef-config/releases',
    'homepage_uri'    => s.homepage,
  }

  s.rdoc_options     = ['--charset=UTF-8']
  s.extra_rdoc_files = %w(README.md LICENSE)

  # s.required_ruby_version     = '>= 2.5.0'
  # s.required_rubygems_version = '>= 2.7.0'

  s.add_development_dependency('chef')
  s.add_development_dependency('test-kitchen')

  s.add_runtime_dependency('deploy-context')

  # s.add_runtime_dependency('colorator',             '~> 1.0')
  # s.add_runtime_dependency('em-websocket',          '~> 0.5')
  # s.add_runtime_dependency('i18n',                  '~> 1.0')
  # s.add_runtime_dependency('jekyll-sass-converter', '>= 2.0', '< 4.0')
  # s.add_runtime_dependency('jekyll-watch',          '~> 2.0')
  # s.add_runtime_dependency('kramdown',              '~> 2.3', '>= 2.3.1')
  # s.add_runtime_dependency('kramdown-parser-gfm',   '~> 1.0')
  # s.add_runtime_dependency('liquid',                '~> 4.0')
  # s.add_runtime_dependency('mercenary',             '>= 0.3.6', '< 0.5')
  # s.add_runtime_dependency('pathutil',              '~> 0.9')
  # s.add_runtime_dependency('rouge',                 '>= 3.0', '< 5.0')
  # s.add_runtime_dependency('safe_yaml',             '~> 1.0')
  # s.add_runtime_dependency('terminal-table',        '>= 1.8', '< 4.0')
  # s.add_runtime_dependency('webrick',               '~> 1.7')
end


