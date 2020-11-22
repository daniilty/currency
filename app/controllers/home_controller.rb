class HomeController < ApplicationController
  def admin
    @forced = Forced.new
    arr1 = []
    @dates = []
    Forced.all.each do |f|
      arr1 << f.value
      @dates << f.dt.to_s
    end
    @values = "[ #{arr1.join(', ')} ]"
  end
  def index
    @current = Curr.first.current
  end
  def new_forced
    base = params[:forced][:dt]
    val = params[:forced][:value]
    dt = DateTime.now
    if val.to_f == "0.0"
      redirect_to home_admin_url, alert: 'You must provide a numeric value' and return
    end
    if base.empty?
      redirect_to home_admin_url, alert: 'You must provide date to process the form' and return
    end
    if base.split('T').size < 2
      date = base.split('T')[0].split('-')
      dt = DateTime.civil_from_format(:local,date[0].to_i, date[1].to_i, date[2].to_i)
    else
      time = base.split('T')[1].split(':')
      date = base.split('T')[0].split('-')
      dt = DateTime.civil_from_format(:local, date[0].to_i, date[1].to_i, date[2].to_i, time[0].to_i, time[1].to_i)
    end
    @forced = Forced.create(value: val, dt: dt)
    if @forced.save
      Curr.first.update_attribute(:current, val)
      Sidekiq::Cron::Job.destroy_all!
      ActionCable.server.broadcast "upd_channel", message: val
      TimerWorker.perform_at(dt)
      redirect_to root_url, alert: 'All fine'
    else
      redirect_to home_admin_url, alert: 'Something went wrong' and return
    end
  end
end
