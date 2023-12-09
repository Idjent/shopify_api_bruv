# frozen_string_literal: true

require_relative 'lib/shopify_api_bruv/version'

Gem::Specification.new do |spec|
  spec.name = 'shopify_api_bruv'
  spec.version = ShopifyApiBruv::VERSION
  spec.authors = ['Idjent']

  spec.summary = ''
  spec.homepage = 'https://github.com/Idjent/shopify_api_bruv'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    %x(git ls-files -z).split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(
        'bin/',
        'test/',
        'spec/',
        'features/',
        '.git',
        '.circleci',
        'appveyor'
      )
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency('httparty')
  spec.add_dependency('logger')

  spec.add_development_dependency('dotenv')
  spec.add_development_dependency('rubocop')
  spec.add_development_dependency('rubocop-performance')
  spec.add_development_dependency('rubocop-shopify')

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
