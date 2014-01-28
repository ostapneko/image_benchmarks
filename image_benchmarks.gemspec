# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'image_benchmarks/version'

Gem::Specification.new do |spec|
  spec.name          = "image_benchmarks"
  spec.version       = ImageBenchmarks::VERSION
  spec.authors       = ["Ostapneko"]
  spec.email         = ["ostapneko@gmail.com"]
  spec.summary       = %q{Benchmark to compare RMagick, minimagick and image_science}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "image_science"
  spec.add_dependency "rmagick"
  spec.add_dependency "mini_magick"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
