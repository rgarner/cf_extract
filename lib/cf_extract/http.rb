require 'net/http'
require 'timeout'

module Net #:nodoc:
  class HTTPResponse #:nodoc:
    def success?; false; end
    def redirect?; false; end
  end
  class HTTPSuccess < HTTPResponse #:nodoc:
    def success?; true; end
  end unless defined? HTTPSuccess.success?
  class HTTPRedirection < HTTPResponse #:nodoc:
    def redirect?; true; end
  end
end

class NilClass
  def success?; false; end
end

module CfExtract
  GOOGLE_AGENT = 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)'
  class HTTP
    def self.construct_complete_url(base_url, additional_url)
      parsed_additional_url ||= URI(additional_url)
      case parsed_additional_url.scheme
        when nil
          u = base_url.is_a?(URI) ? base_url : URI(base_url)
          if additional_url[0].chr == '/'
            "#{u.scheme}://#{u.host}#{additional_url}"
          elsif additional_url[0].chr == '?'
            "#{u.scheme}://#{u.host}#{u.path}#{additional_url}"
          elsif u.path.nil? || u.path == ''
            "#{u.scheme}://#{u.host}/#{additional_url}"
          elsif u.path[0].chr == '/'
            "#{u.scheme}://#{u.host}#{u.path}/#{additional_url}"
          else
            "#{u.scheme}://#{u.host}/#{u.path}/#{additional_url}"
          end
      else
        additional_url
      end
    end

    def self.get_follow_redirect(url)
      url.is_a?(URI) ? url : URI(url)
      raise ArgumentError.new "Expected absolute url, got #{url}" unless url.absolute?
      begin
        http = Net::HTTP.new(url.host, url.port)
        if url.scheme == 'https'
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end

        response = long_operation "#{url} ... " do
          http.start { |h| h.request(Net::HTTP::Get.new(url.request_uri, "User-Agent" => GOOGLE_AGENT)) }
        end

        if response.redirect?
          return get_follow_redirect(URI.parse(construct_complete_url(url, response['Location'])))
        else
          return response
        end
      rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, Errno::ECONNREFUSED, EOFError => e
        p e
        nil
      end
    end
  end
end