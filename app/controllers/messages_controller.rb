class MessagesController < ApplicationController
	def index
		@messages = Message.all
	end

	def new
		@message = Message.new
	end

	def create
		@message = Message.new message_params
		if @message.save
			ActionCable.server.broadcast "chat", data: render_message(@message)
			flash[:success] = 'Create message susccessful!'
			redirect_to messages_path
		else
			render 'new'
		end
	end

	def render_message(message)
	  ApplicationController.render(partial: 'messages/message', locals: {message: message})
	end

	private
	def message_params
		params.require(:message).permit(:body)
	end
end
