// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require raty-js
//= require chartkick
//= require Chart.bundle
//= require moment
//= require fullcalendar
//= require rails-ujs
//= require activestorage
//= require_tree .

$(function () {
  // メニューの スイッチになる部分
  $('.menu-trigger').on('click', function () {
    $('html, body').animate({ 'scrollTop': 0 }, 300);
    $(this).toggleClass('active');
    $('body').toggleClass('open');
    $('.overlay').toggleClass('open');
    $('#menu').fadeToggle();
    return false;
  });
  // メニュー表示中に他の部分に触れたら閉じる
  $('.overlay').on('click', function () {
    if ($(this).hasClass('open')) {
      $(this).removeClass('open');
      $('body').removeClass('open');
      $('.menu-trigger').removeClass('active');
      $('#menu').fadeToggle();
    }
  });

  // 星評価に使用しているratyに関する表記
  $('#star').raty({
    starType: 'img',
    size: 36,
    cancelOff: '/cancel-off.png',
    cancelOn: '/cancel-on.png',
    starHalf: '/star-half.png',
    starOff: '/star-off.png',
    starOn: '/star-on.png',
    scoreName: 'rate'});

  $(".layer", ".eyecatch").hide().fadeIn(500);

});

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
