function initRaty() {
  if ($(".raty-read").length) {
    $(".raty-read").raty({
      starType: "i",
      space: false,
      readOnly: true,
      score: function () {
        return $(this).data("rating");
      },
    });
  }

  if ($(".raty").length) {
    $(".raty").raty({
      starType: "i",
      target: "#review_rate", 
      targetKeep: true,
      targetType: "number",
      space: true,
      score: function () {
        return $(this).data("rating");
      },
    });
  }
}
