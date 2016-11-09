# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
      stream_from "room_channel"
      stream_from "room_channel_#{message_user.id}"
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end