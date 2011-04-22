
Gem::Specification.new do |s|
  s.name = %q{searchstorm_core}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gyorgy Frivolt"]
  s.date = %q{2011-04-19}
  s.description = %q{Have a search motor built on the top of Solr, a highly customizable, scalable and well performing search engine. You are only few steps away from creating your own search motor.}
  s.email = %q{gyorgy.frivolt@gmail.com}
  s.files        = Dir['LICENSE', 'README.rdoc', 'app/**/*', 'public/**/*', 'config/**/*', 'lib/**/*', 'db/**/*']
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{Searching made so simple that it is even a fun}

  s.add_dependency(%q<rails>, ["~> 3.0.5"])
  s.add_dependency(%q<haml>, [">= 0"])
  s.add_dependency(%q<will_paginate>, [">= 0"])
  s.add_dependency(%q<sunspot>, ["~> 1.2.1"])
  s.add_dependency(%q<sunspot_rails>, ["~> 1.2.1"])
end

