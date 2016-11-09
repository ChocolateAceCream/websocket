class MessagesController < ApplicationController
  before_action :logged_in_user
  before_action :get_messages

  def index
  end

  def create
    message = current_user.messages.build(message_params)
    if message.save
        ActionCable.server.broadcast 'room_channel',
                                    message: render_message(message)
        #head :ok
        #head :ok sets render to return an empty response (so just the header,
        #no body) with status 200.  head :ok is shorthand for render nothing:
        #true, status: :ok.:w
        #
        message.mentions.each do |mention|
            ActionCable.server.broadcase 'room_channel_#{mention.id}',
                                    mention: true
        end
    end
  end

  private

    def get_messages
      @messages = Message.for_display
      @message  = current_user.messages.build
    end

    def message_params
      params.require(:message).permit(:content)
    end

    def render_message(message)
        render(partial: "message", locals: { message: message})
    end
end
