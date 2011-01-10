require 'heroku_delayed_job_autoscale/managers/local'
require 'heroku_delayed_job_autoscale/managers/heroku'

module HerokuDelayedJobAutoscale
  module Autoscale
    
    @@autoscale_manager = HerokuDelayedJobAutoscale::Manager::Local

    def enqueue(job)
      Rails.logger.debug "enqueue"

      if autoscale_client.qty.zero?
        autoscale_client.scale_up
      end
    end

    def perform
      raise "Not implemented"
    end

    def before(job)
      Rails.logger.debug "before #{job.inspect}"
    end

    def after(job)
      # after is triggered before the job is removed, hence we see if this is the last job
      autoscale_client.scale_down unless job.class.count - 1  > 0
    end

    def success(job)
      Rails.logger.debug "success #{job.inspect}"
    end

    def error(job, exception)
      Rails.logger.debug "error #{job.inspect}"
    end

    def failure
      Rails.logger.debug "failure #{job.inspect}"
    end

    protected
    def autoscale_client
      @autoscale_client ||= @@autoscale_manager.new
    end

  end
end
