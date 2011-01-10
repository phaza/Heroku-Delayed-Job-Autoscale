require 'rubygems'
require 'heroku_delayed_job_autoscale/managers/local'
require 'heroku_delayed_job_autoscale/managers/heroku'
require 'heroku_delayed_job_autoscale/managers/stub'

module HerokuDelayedJobAutoscale
  module Autoscale
    
    @@autoscale_manager = HerokuDelayedJobAutoscale::Manager::Local
    
    def self.autoscale_manager
      @@autoscale_manager
    end
    
    def self.autoscale_manager=(manager)
      @@autoscale_manager = manager
    end
    
    def enqueue(job)
      autoscale_enqueue(job)
    end

    def autoscale_enqueue(job)
      Rails.logger.debug "enqueue"

      if autoscale_client.qty.zero?
        autoscale_client.scale_up
      end
    end

    def perform
      raise "Not implemented"
    end
    
    def after(job)
      autoscale_after(job)
    end
    
    def autoscale_after(job)
      # after is triggered before the job is removed, hence we see if this is the last job
      autoscale_client.scale_down unless job.class.count - 1  > 0
    end

    protected
    def autoscale_client
      @autoscale_client ||= self.class.autoscale_manager.new
    end

  end
end
