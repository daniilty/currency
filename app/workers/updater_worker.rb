class UpdaterWorker
  include Sidekiq::Worker

  def perform(*args)
    UpdateCurrencyJob.perform_now 
  end
end
