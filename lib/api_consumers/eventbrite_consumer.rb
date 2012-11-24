# Take data from Eventbrite and put it into a format that our app understands.

require 'eventbrite-client'

class EventbriteConsumer
  include ActionView::Helpers::SanitizeHelper

  def initialize(credentials)
    @client = EventbriteClient.new(credentials)
  end

  def fetch(options = {})
    data   = @client.user_list_events(options)
    process data
  end

  def search(options = {})
    data = @client.event_search(options)

    if data['events'].length > 1
      data['events'].shift
    end

    process data
  end

  private

  def process(data)
    events = []

    data['events'].each do |event|
      event = event['event']
      events.push({
        import_id:        event['id'],
        import_source:    'eventbrite',
        title:            event['title'],
        description:      sanitize(event['description'], :tags => %w(h1 h2 h3 h4 h5 h6 p br)),
        tags:             event['tags'].split(','),
        categories:       event['category'].split(','),
        status:           event['status'],
        capacity:         event['capacity'],
        sold:             event['num_attendee_rows'],
        start:            event['start_date'],
        metum: {
            title:          event['title'],
            description:    event['title'],
            keywords:       "#{event['category']}, #{event['tags']}"
        },
        time: {
            start:        event['start_date'],
            end:          event['end_date'],
            zone:         event['timezone'],
            offset:       event['timezone_offset']
        },
        venue: {
            import_id:    event['venue']['id'],
            import_source: 'eventbrite',
            name:         event['venue']['name'],
            address:      event['venue']['address'] + event['venue']['address_2'],
            city:         event['venue']['city'],
            region:       event['venue']['region'],
            country:      event['venue']['country'],
            postal_code:  event['venue']['postal_code'],
            longitude:    event['venue']['longitude'],
            latitude:     event['venue']['latitude'],
        },
        organizer: {
            import_id:    event['organizer']['id'],
            import_source: 'eventbrite',
            name:         event['organizer']['name'],
            description:  event['organizer']['description'],
            url:          event['organizer']['url']
        }
    })
    end

    events
  end
end