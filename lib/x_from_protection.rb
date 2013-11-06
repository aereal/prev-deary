module Deary
  module XFromProtection
    module Helpers
      def origin
        request.env['HTTP_ORIGIN']
      end

      def x_from
        request.env['HTTP_X_FROM']
      end

      def matched_host?
        request.host == settings.host
      end

      def given_x_from?
        !!x_from
      end

      def origin_matched_x_from?
        URI.parse(origin).normalize == URI.parse(x_from).normalize
      end

      def valid_origin_header?
        !x_from || origin_matched_x_from?
      end

      def harmful_request?
        !(matched_host? && given_x_from? && valid_origin_header?)
      end
    end

    def self.registered(app)
      app.helpers Helpers
      app.before do
        if !request.idempotent? && harmful_request?
          logger.warn "Attack Detected: X-From: #{x_from}; Origin: #{origin};"
          halt 403
        end
      end
    end
  end
end
