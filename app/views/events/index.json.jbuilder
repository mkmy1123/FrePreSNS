json.array!(@events) do |event|
  json.extract! event, :id, :title, :description
  json.start event.start_time
  json.end event.end_time
  json.allDay event.all_day
  json.url event_url(event, format: :html)
end