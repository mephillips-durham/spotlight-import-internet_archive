require_dependency "spotlight/import/internet_archive/application_controller"

module Spotlight::Import::InternetArchive
  class ResourcesController < ApplicationController
  
    # GET /resources/new
    # GET /resources/new.json
    def new
      @resource = Resource.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @resource }
      end
    end

    # POST /resources
    # POST /resources.json
    def create
      @resource = Resource.new(params[:resource])
  
      respond_to do |format|
        if @resource.save
          format.html { redirect_to @resource, notice: 'Resource was successfully created.' }
          format.json { render json: @resource, status: :created, location: @resource }
        else
          format.html { render action: "new" }
          format.json { render json: @resource.errors, status: :unprocessable_entity }
        end
      end
    end

  end
end
