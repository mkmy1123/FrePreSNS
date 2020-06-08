// サイト全体に動きをつけるため、全ページ共通の箱にアニメーションをつけている
$(document).ready(function () {
  var EffectTime = 700;
  var DelayTime = 500;
  $(".content-box").css({ opacity: 0 });
  $(window).on("scroll load", function () {
    var scMiddle = $(this).scrollTop() + $(this).height();
    var listPos = $(".content-box").offset().top;
    if (listPos < scMiddle) {
      $(".content-box").each(function (index) {
        $(this)
          .delay(DelayTime * index)
          .animate({ opacity: 1 }, EffectTime);
      });
    }
  });
});
