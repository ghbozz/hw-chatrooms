class ChatroomsController < ApplicationController
  before_action :set_chatrooms, only: %i(index show)

  def index
  end

  def show
    @chatroom = Chatroom.find(params[:id])
  end

  private

  def set_chatrooms
    @chatrooms = Chatroom.all
  end
end
