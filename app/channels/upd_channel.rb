class UpdChannel < ApplicationCable::Channel
  def subscribed
    stream_from "upd_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
