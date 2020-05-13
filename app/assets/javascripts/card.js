window.onload = function(){
  console.log("ok")
  var form = $("#charge_form");
  Payjp.setPublicKey("pk_test_6d89c8792c4bb812515e783f"); //(自身の公開鍵)

  $("#charge_form").on("click", ".btn-default1", function(e) {
    e.preventDefault();
    form.find("input[type=submit]").prop("disabled", true);
    var card = {
        number: parseInt($(".input-default-number").val()),
        cvc: parseInt($(".input-default-cvc").val()),
        exp_month: parseInt($(".select-default-month").val()),
        exp_year: parseInt($(".select-default-year").val())
    };
    Payjp.createToken(card, function(status, response) {
      if (status == 200) {  //エラーがなければ
        $(".input-default-number").removeAttr("name");
        $(".input-default-cvc").removeAttr("name");
        $(".select-default-month").removeAttr("name");
        $(".select-default-year").removeAttr("name");

        var token = response.id;
        $("#charge_form").append($('<input type="hidden" name="payjp-token" class="payjp-token" />').val(token));
        $("#charge_form")[0].submit();

      }
      else {
        alert("error")
        form.find('button').prop('disabled', false);
      }
    });
  });
};