require 'rails'
require 'spotlight/import/internet_archive'

module Spotlight::Import::InternetArchive
  class Engine < ::Rails::Engine
    isolate_namespace Spotlight::Import::InternetArchive

  end
end