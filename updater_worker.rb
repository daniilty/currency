class UpdaterWorker
  include Sidekiq::Worker

  def perform()
      UpdateCurrencyJob.perform_now
  end
end
