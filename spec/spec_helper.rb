require "tempfile"

module Runner
  def run_spec(text, formatter = 'progress')
    path = "#{Dir.tmpdir}/#{Process.pid}"
    File.open(path, "w") do |file|
      file.puts <<RSPEC_CONFIGURE
RSpec.configure do |config|
  config.mock_with ''
end
RSPEC_CONFIGURE

      file.puts text
    end
    `rspec --format #{formatter} #{path} 2>&1`
  end
end

RSpec.configure do |config|
  config.include Runner
  config.mock_with ''
  config.run_all_when_everything_filtered = true
  config.filter_run :focused => true
  config.alias_example_to :fit, :focused => true
end
