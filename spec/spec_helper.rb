require 'tempfile'

require 'pry'

DMATE_ROOT = File.expand_path(File.dirname(__FILE__) + '/..')
$LOAD_PATH << File.join(DMATE_ROOT, 'Support/lib')
Dir[DMATE_ROOT + '/spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.include DMate::Support::CodeToFile

  config.order = 'random'

  # The grammar specs shell out to gtm (GrammarTestMate, Allan Odgaard's
  # grammar tester, never open sourced and dead as a 32-bit binary; see
  # _NOTES.md). Exclude them unless a working gtm is on the PATH, so they
  # come back automatically if the harness is ever revived.
  config.filter_run_excluding :gtm unless system('which -s gtm')

  config.after :example do
    DMate::Support::TempFiles.clear
  end
end
