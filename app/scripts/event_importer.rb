class EventImporter
  def self.import
    eb_auth = {
        app_key: API_PROVIDERS['eventbrite']['app_key'],
        user_key: API_PROVIDERS['eventbrite']['user_key']
    }
    eb_consumer = EventbriteConsumer.new(eb_auth)
    eb_events = eb_consumer.fetch

    API_PROVIDERS['eventbrite']['organizers'].each do |organizer|
      begin
        eb_events.concat(eb_consumer.search({organizer: organizer}))
      end
    end

    eb_events.each do |event|
      persisted_event = Event.where(import_id: event[:import_id]).where(import_source: event[:import_source]).first

      if persisted_event.nil?
        Event.create(event)
      else
        persisted_event.update_attributes(event)
      end
    end
  end
end