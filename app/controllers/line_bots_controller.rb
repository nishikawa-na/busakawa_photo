class LineBotsController < ApplicationController
  require 'line/bot'
  protect_from_forgery :except => [:webhook]
  skip_before_action :require_login, only: [:webhook]

  def new
    if current_user.line_user_id.present?
      flash[:notice] = "LINE連携が完了しました"
      redirect_to posts_path
    else
      @line_user_id_token = params[:state]
    end
  end

  def create
    @line_bot_token = LineBotToken.find_by(line_user_id_token: params[:line_user_id_token])
    current_user.update(line_user_id: @line_bot_token.line_user_id)
    @line_bot_token.destroy
    flash[:notice] = "LINE連携が完了しました"
    redirect_to posts_path
  end

  def official
  end

  def webhook
    body = request.body.read
    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Follow
        user_id = event['source']['userId']
        token = SecureRandom.alphanumeric(15)
        LineBotToken.create(line_user_id: user_id, line_user_id_token: token)
        message = [
          {type: "text", text: "下記URLよりLINE認証を行ってください"},
          {type: "text", text: "https://busakawa.com/line_bots/new?state=#{token}&openExternalBrowser=1"}
        ]
        client.push_message(user_id,message)
      end
    end
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_id = ENV["LINE_CHANNEL_ID"]
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

end
