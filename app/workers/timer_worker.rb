class TimerWorker
  include Sidekiq::Worker

  def perform(*args)
    puts "yippie"
    Sidekiq::Cron::Job.create(name: 'Currency updater', cron:  '*/1 * * * *', class: 'UpdaterWorker')
  end
end
