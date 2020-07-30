// サイト全体に動きをつけるため、全ページ共通の箱にアニメーションをつけている
$(function () {
  let effectTime = 700;
  let delayTime = 500;
  $(".content-box").css({ opacity: 0 });
  $(window).on("scroll load", function () {
    let scMiddle = $(this).scrollTop() + $(this).height();
    let listPos = $(".content-box").offset().top;
    if (listPos < scMiddle) {
      $(".content-box").each(function (index) {
        $(this)
          .delay(delayTime * index)
          .animate({ opacity: 1 }, effectTime);
      });
    }
  });
});
