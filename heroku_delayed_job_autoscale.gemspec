# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "heroku_delayed_job_autoscale/version"

Gem::Specification.new do |s|
  s.name        = "heroku_delayed_job_autoscale"
  s.version     = HerokuDelayedJobAutoscale::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Peter Haza"]
  s.email       = ["peter.haza@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A simple gem which enables automatic on/off for workers in heroku, saving you money.}
  s.description = %q{The module within this gem simply listens for enqueues and finished jobs.
    On enqueue it'll fire up a new worker instance if none are running,
    on finish it'll shut down the worker if there are no more jobs.}

  s.rubyforge_project = "heroku_delayed_job_autoscale"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency 'heroku', '>= 1'
  s.add_dependency 'rush', '>= 0.6'
end
