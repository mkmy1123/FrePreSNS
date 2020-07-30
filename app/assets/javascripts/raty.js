$(function () {
  // 星評価に使用しているratyに関する表記
  $('#star').raty({
    starType: 'img',
    size: 36,
    cancelOff: '/cancel-off.png',
    cancelOn: '/cancel-on.png',
    starHalf: '/star-half.png',
    starOff: '/star-off.png',
    starOn: '/star-on.png',
    scoreName: 'rate'
  });
})
