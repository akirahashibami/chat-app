$ ->
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room: $('#user-chat-room').data('room') },
    connected: ->
      # 通信が確立された時の処理

    disconnected: ->
      # 通信が切断された時の処理

    received: (data) ->
      # データが送信されてきた時の処理
      $('#add-message').append data['message']

    speak: (message, user) ->
      # channelのspeakアクションにmessageパラメータを渡す
      @perform 'speak', {message: message, user: user}

  # チャットを送る
  $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
    # return(Enter)が押された時
    if event.keyCode is 13
      #channel speakへ、event.target.valueを引数に
      App.room.speak event.target.value, $('[data-user]').attr('data-user')
      # inputの中身を空に
      event.target.value = ''
      event.preventDefault()
