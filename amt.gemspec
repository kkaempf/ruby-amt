# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require "amt/version"

Gem::Specification.new do |s|
  s.name        = "amt"
  s.version     = Amt::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Klaus Kämpf"]
  s.email       = ["kkaempf@suse.de"]
  s.homepage    = "http://www.github.com/kkaempf/ruby-amt"
  s.summary = "Command line interface to Intel AMT"
  s.description = "ruby-amt gives you control over KVM (console
redirection via VNC) and SOL (serial-over-lan) function of Intel AMT
(part of Intel vPro)"

  s.required_rubygems_version = ">= 1.3.6"
  s.add_development_dependency("yard", [">= 0.5"])
  s.add_dependency("wbem", [">= 0.4"])

  s.files         = `git ls-files`.split("\n")
  s.files.reject! { |fn| fn == '.gitignore' }
  s.require_path = 'lib'
  s.extra_rdoc_files    = Dir['README.rdoc', 'CHANGES.rdoc', 'MIT-LICENSE']
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.post_install_message = <<-POST_INSTALL_MESSAGE
  ____
/@    ~-.
\/ __ .- | remember to have fun! 
 // //  @  

  POST_INSTALL_MESSAGE
end
