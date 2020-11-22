class UpdateCurrencyJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @doc = HTTParty.get('https://www.banki.ru/products/currency/usd/')
    if @doc.body.empty?
      return
    end
    @page = Nokogiri::HTML(@doc)
    @inf =  @page.xpath('//div[@class = "currency-table__large-text"]')[0].text
    if Curr.first.nil?
      Curr.create(current: @inf.to_s)
    end
    @curr = Curr.first
    @curr.current = @inf.to_s
    @curr.save
    ActionCable.server.broadcast "upd_channel", message: @curr.current
  end
end
