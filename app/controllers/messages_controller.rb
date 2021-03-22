class MessagesController < ApplicationController
  def create
    @message = Message.new(
      message_params.merge(chatroom_id: params[:chatroom_id], user: current_user)
    )
    
    respond_to do |format|
      if @message.save
        format.html { redirect_to chatroom_path(@message.chatroom) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@message, partial: 'messages/form', locals: { message: @message }) }
      end
    end
  end

  def edit
    @message = Message.find(params[:id])
    @chatroom = @message.chatroom
  end

  def update
    @message = Message.find(params[:id])
    @message.update(message_params)
    redirect_to chatroom_path(@message.chatroom)
  end

  def destroy
    Message.find(params[:id]).destroy
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
