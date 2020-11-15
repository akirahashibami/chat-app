javascript:
  $(document).ready(function(){

    // グループ・友達・お気に入りの中身を表示非表示を行う
    // グループのタブ
    $('.current_user_data__groups--tab').on('click', function(){
      let parent = $('.current_user_data__groups--group');
      // クラス名がついているか判断し付け外しを行う
      if (!parent.hasClass('is-close')) {
        parent.addClass('is-close');
      } else {
        parent.removeClass('is-close');
      }
    });
    // 友達のタブ
    $('.current_user_data__friends--tab').on('click', function(){
      let parent = $('.current_user_data__friends--list');
      // クラス名がついているか判断し付け外しを行う
      if (!parent.hasClass('is-close')) {
        parent.addClass('is-close');
      } else {
        parent.removeClass('is-close');
      }
    });
    // お気に入りのタブ
    $('.current_user_data__favorite-rooms--tab').on('click', function(){
      let parent = $('.current_user_data__favorite-rooms--list');
      // クラス名がついているか判断し付け外しを行う
      if (!parent.hasClass('is-close')) {
        parent.addClass('is-close');
      } else {
        parent.removeClass('is-close');
      }
    });

  });
