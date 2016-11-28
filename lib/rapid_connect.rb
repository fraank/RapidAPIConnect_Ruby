class RapidConnect

  def initialize project = false, token = false
    @project = project
    @token = token
  end

  def load_config file
    config = YAML::load(File.open(file))
    @project = config['rapid_connect']['project'] if config['rapid_connect'] && config['rapid_connect']['project']
    @token = config['rapid_connect']['token'] if config['rapid_connect'] && config['rapid_connect']['token']
  end

  def project
    @project
  end

  def token
    @token
  end

  def call pack, block, args = {}
    if @project && @token
      @request = Request.new(@project, @token)
      response = @request.request(pack, block, args)
      return response if response
    end
    return {
      'outcome' => 'error',
      'msg' => 'connection error'
    }
  end

end

require './lib/rapid_connect/request'