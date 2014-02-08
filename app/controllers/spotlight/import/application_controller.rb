require 'spotlight/import/internet_archive'

module Spotlight::Import::InternetArchive
  # Inherit from the host app's ApplicationController
  # This will configure e.g. the layout used by the host
  class ApplicationController < ::ApplicationController

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to main_app.root_url, :alert => exception.message
    end

  end
end
