javascript:
  $(document).ready(function(){

    // ユーザー編集即時プレビュー機能
    function readURL(input) {
      if (input.files && input.files[0]){
        let reader = new FileReader();

        reader.onload = function(e){
          $('#img-prev').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
      }
    }

    $('.file-field').on('change',function(){
      $('#img-prev').removeClass('hidden-img');
      readURL(this);
    });
  });
