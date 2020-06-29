$(function () {
  $("#calendar").fullCalendar({
    events: "/events.json",
    timeFormat: "H(:mm)",
    eventColor: "#4D4150",
    eventTextColor: "#fff",
    height: 1000,
    eventRender: function (event, element) {
      element.css("font-size", "0.8em");
      element.css("padding", "5px");
    },
  });
});
