require 'faraday'
require 'faraday_middleware'

module Spotlight::Import::InternetArchive
  class Resource < ActiveRecord::Base
    belongs_to :solr_document
    serialize :data, Hash

    before_save do
      harvest! if url_changed?
    end

    after_save if: :data_changed? do
      index!
      self.update_columns indexed_at: Time.current
    end

    def index!
      Blacklight.solr.add solr_doc
    end

    def solr_doc
      h = { 
        id: solr_doc_id,
        spotlight_import_internet_archive_id_isi: id
      }

      h.merge! opengraph_properties

      h.merge! metadata_properties
    end

    def solr_doc_id
      url.split("/").last.parameterize
    end

    def harvest!
      response = Faraday.get url
      data[:raw_body] = response.body
      fetch_metadata!
    end

    def body
      @body ||= Nokogiri::HTML.parse data[:raw_body]
    end

    def opengraph
      @opengraph ||= begin
        page = Hash.new

        body.css('meta').select { |m| m.attribute('property') }.each do |m|
          page[m.attribute('property').to_s.parameterize("_")] = m.attribute('content').to_s
        end

        page
      end
    end

    def opengraph_properties
      opengraph.map do |k,v|
        ["#{k}_tesim", v]
      end.to_h
    end

    def metadata
      if data[:metadata].nil?
        fetch_metadata!
      end

      @metadata ||= Nokogiri::XML.parse data[:metadata]
    end

    def metadata_properties
      metadata.xpath('//*').map do |node|
        ["#{node.name}_tesim", node.text]
      end.to_h
    end

    def fetch_metadata!
      data[:metadata] = begin
        href = body.css('.fileFormats').select do |x| 
          x.at_css('.ttlHeader').text == "Information"
        end.first.css('a').select do |a|
          a.attribute("href").text.ends_with? "_meta.xml"
        end.first.attribute("href").text

        conn = Faraday.new url: 'https://archive.org' do|b|
          b.use FaradayMiddleware::FollowRedirects
          b.adapter Faraday.default_adapter
        end

        response = conn.get href
        response.body
      end
    end

  end
end
