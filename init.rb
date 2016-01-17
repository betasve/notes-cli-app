#!/usr/bin/env ruby

#### Notebook App ####
#
# Launch this file from the command line to get started.
#

# Set the application root for easy reference.
APP_ROOT = File.dirname(__FILE__)

require_relative('lib/notebook')
require_relative('lib/radio')
require_relative('lib/records_serializer.rb')
require_relative('lib/translator.rb')
require_relative('lib/note.rb')
require_relative('lib/tag.rb')
require_relative('support/helpers.rb')
require_relative('support/string_extend.rb')

notebook = Notebook.new()
notebook.run
