require 'minitest/autorun'
require 'rapid_connect'
require 'yaml'

class RequestTest < Minitest::Test

  def test_connect

    connection = RapidConnect.new()
    config_file =  File.join(File.dirname(__FILE__), 'config.yml')
    connection.load_config(config_file)

    p "no project given. please ensure that config.yml is correct" unless connection.project
    p "no token given. please ensure that config.yml is correct" unless connection.token

    response = connection.call('Github', 'getUserStarredRepositories', {
      accessToken: '293476c4af1fdf55a8b7ec32b5ceb602a13c4429',
      user: 'twitter',
      page: '1',
      perPage: '10'
    })
  
    # check result
    assert_equal response['project'], connection.project
    assert_equal response['package'], 'Github'
    assert_equal response['block'], 'getUserStarredRepositories'
    assert_equal response['outcome'], 'success'
    assert_equal true, (response['payload'].size > 0)

  end

end