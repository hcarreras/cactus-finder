require 'watir'
module Scrapers
  class Biltorvet
    SEARCH_PAGE = "https://www.biltorvet.dk/soeg/15342452"

    def execute
      doc.search('.result-block .card').map do |vehicle_card|
        mapper = Mapper.new(vehicle_card)
        Vehicle.new(
          title: mapper.title,
          location: mapper.location,
          web_source: "Biltorvet"
        )
      end
    end

    def doc
      @doc ||= begin
        browser.goto SEARCH_PAGE
        browser.button(value: 'Accepter alle').click
        Nokogiri::HTML(browser.html)
      end
    end

    def browser
      Watir::Browser.new(
        :chrome,
         args: %w[--headless --no-sandbox --disable-dev-shm-usage --disable-gpu --remote-debugging-port=9222])
    end

    class Mapper
      attr_reader :vehicle_card

      def initialize(vehicle_card)
        @vehicle_card = vehicle_card
      end

      def location
        vehicle_card.search('.card-details__container')[0].text.squish
      end

      def title
        vehicle_card.search('.card__text').map(&:text).join(" ").squish
      end
    end
  end
end
