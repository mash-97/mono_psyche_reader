require_relative 'lib/mono_psyche_reader/version'

Gem::Specification.new do |spec|
  spec.name          = "mono_psyche_reader"
  spec.version       = MonoPsycheReader::VERSION
  spec.authors       = ["mash-97"]
  spec.email         = ["mahimnhd97@gmail.com"]

  spec.summary       = %q{Mono-Psyche Reader}
  spec.description   = %q{It reads mono-psyches monologues. Reads Reminders/Tasks composed in mono-psyches files.}
  spec.homepage      = "https://github.com/mash-97/mono_psyche_reader"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://github.com/mash-97/mono_psyche_reader.git"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mash-97/mono_psyche_reader"
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
