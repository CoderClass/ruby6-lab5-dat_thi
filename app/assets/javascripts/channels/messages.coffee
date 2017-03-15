App.messages = App.cable.subscriptions.create "MessagesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log 'connected!'



  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log 'disconnect!'

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log("client receives ", data)
    $('.messages').prepend(data.message)

  $(document).on "turbolinks:load", ->
	  $("form#js-socket").submit (event) ->
	    console.log("stopping submitting via HTTP")
	    event.preventDefault()

	    # use jQuery to find the text input:
	    $input = $(this).find('input:text')
	    data = {message: {body: $input.val()}}
	    console.log("=============>sending over socket: ", data)
	    App.messages.send(data)
	    # clear text field
	    $input.val('')
