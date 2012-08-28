Gem::Specification.new do |gem|
  gem.authors = ["Justin Rhinesmith",  "Vlatko Duvnjak"]
  gem.description = %q{Ruby wrapper for the Graphite API}
  gem.name = 'blacklead'
  gem.version = '0.0.1'
  gem.require_paths = ['lib','config']
  gem.files = Dir["lib/**/*.rb", "app/**/**/*.rb", "config/**/*"] 
  gem.summary = gem.description
  gem.platform = Gem::Platform::CURRENT
  gem.add_dependency 'httparty'
end