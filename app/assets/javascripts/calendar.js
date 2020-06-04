$(function () {
  $("#calendar").fullCalendar({
    events: "/events.json",
    timeFormat: "H(:mm)",
    eventColor: "#4D4150",
    eventTextColor: "#fff",
    eventRender: function (event, element) {
      element.css("font-size", "0.8em");
      element.css("padding", "5px");
    },
  });
});
