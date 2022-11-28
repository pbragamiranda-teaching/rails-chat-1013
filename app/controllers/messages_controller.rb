class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.chatroom = Chatroom.find(params[:chatroom_id])

    if @message.save
      # redirect_to chatroom_path(@message.chatroom)
      ChatroomChannel.broadcast_to(
        @message.chatroom,
        render_to_string(partial: "message", locals: { message: @message })
      )
      head :ok
    else
      render "chatroom/show", status: :unprocessable_entity
    end

  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
