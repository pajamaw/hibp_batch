class Api
  HIBP_URI_BASE = "https://haveibeenpwned.com/api/v2".freeze
  HIBP_BREACHED_ACCOUNT ="#{HIBP_URI_BASE}/breachedaccount".freeze
  HIBP_PASTE_ACCOUNT ="#{HIBP_URI_BASE}/pasteaccount".freeze
  HIBP_HEADERS = {:headers => {"User-Agent" => "BV"}}.freeze
  HIBP_PARAMS = nil.freeze

  def self.breached_account?(email)
    JSON.parse(http_client.do_get("#{HIBP_BREACHED_ACCOUNT}/#{CGI.escape(email)}", HIBP_PARAMS, HIBP_HEADERS).body)
  rescue HttpClient::ClientError => ex
    # when a 404 the email is actually clean
    return false if ex.status == 404
  end

private

  def self.http_client
    @http_client ||= HttpClient.new
  end
end
