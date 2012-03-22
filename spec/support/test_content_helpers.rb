module TestContentHelpers
  @@files = {}

  def mock_http_response(file_name)
    mock('Net::HTTPResponse').tap do |response|
      response.stubs(:body => read_test_file(file_name), :header => '', :success? => true, :redirect? => false)
      Net::HTTP.any_instance.stubs(:start).returns(response)
    end
  end

  def test_file_name(file_name)
    File.join(File.dirname(__FILE__), "..", "testdata/#{file_name}")
  end

  def cached_content(file_name)
    @@files[file_name] ||= read_test_file file_name
  end

  def read_test_file(file_name)
    File.open(test_file_name(file_name)).read
  end

  def default_url_options
    {:host => 'test.host'}
  end
end
