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
  $(document).on 'keydown', '[data-behavior~=room_speaker]', (e) ->
    # ctrl(command) + enter(return)が押された時
    if ((e.ctrlKey && !e.metaKey) || (!e.ctrlKey && e.metaKey)) && e.keyCode == 13
        # テキストエリアに何もなければアラート
      if e.target.value == ''
        alert "何か入力して下さい"
        e.target.value = ''
        e.preventDefault()
      else
        #channel speakへ、event.target.valueを引数に
        App.room.speak e.target.value, $('[data-user]').attr('data-user')
        # inputの中身を空に
        e.target.value = ''
        e.preventDefault()
