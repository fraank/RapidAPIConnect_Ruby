require 'net/http'
require 'json'

class RapidConnect::Request

  def initialize project, token
    @project = project
    @token = token
  end

  def url pack, block
    File.join('https://rapidapi.io/connect', File.join(pack, block))
  end 

  def request pack, block, args
    @resp = false
    @args = args
    uri = URI.parse(url(pack, block))  
      Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      req = Net::HTTP::Post.new(uri.path)  
      req.basic_auth @project, @token  
      req.set_form_data(@args)
      @resp = http.request(req)
    end
    if @resp.is_a?(Net::HTTPSuccess)
      data = JSON.parse @resp.body
      return data
    end
    return false
  end

end