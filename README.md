# Heroku Delayed Job Autoscale
Simply put, this gem saves you money on Heroku by only running the workers when you need them.  
When a new job is enqueued, this gem will fire up a new worker instance if none are running. When the job finishes, it'll shut it down.

## Usage
Create a delayed job worker and include HerokuDelayedJobAutoscale::Autoscale:

    class OnImageUpload
      include HerokuDelayedJobAutoscale::Autoscale

      def initialize(media)
        @media = media
      end

      def perform
        @media.create_thumb
      end
    end

Done

## Requirements
* Rush >= 0.6 - https://github.com/heroku/rush
* Heroku client >= 1 - https://github.com/heroku/heroku
* Delayed Job >= 2.1 - https://github.com/collectiveidea/delayed_job

I haven't tested lower versions, but it might work.

## Caution
Autoscale uses two DJ hooks. #after and #enqueue, which it just passes onto two methods autoscale\_after and autoscale\_enqueue.
If you need to use either of those hooks yourself in your DJ worker, make sure you pass on the job to the autoscale\_methods manually.

## Other
Work is based of [pedro's autoscaling branch][1], but adapted for Delayed Job 2.1 and rails 3.

[1]: https://github.com/pedro/delayed_job/tree/autoscaling