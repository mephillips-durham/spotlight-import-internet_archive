require 'spec_helper'

describe Spotlight::Import::InternetArchive::Resource do
  describe "#index!" do
    let(:solr_doc) { double }
    before :each do
      subject.stub(solr_doc: solr_doc)
    end
    it "should add the solr doc to solr" do
      Blacklight.solr.should_receive(:add).with(solr_doc)
      subject.index!
    end
  end

  describe "#solr_doc" do
    before :each do
      subject.stub id: "xyz",
       solr_doc_id: "1",
       opengraph_properties: {},
       metadata_properties: {}
    end

    let(:solr_doc) { subject.solr_doc }

    it "should include an id" do
      expect(solr_doc).to include id: "1"
    end

    it "should include this record id" do
      expect(solr_doc).to include spotlight_import_internet_archive_id_isi: "xyz"
    end

    it "should include opengraph properties" do
      subject.stub opengraph_properties: { a: 1, b: 2}

      expect(solr_doc).to include a: 1, b: 2
    end

    it "should include metadata properties" do
      subject.stub metadata_properties: { c: 1, d: 2}

      expect(solr_doc).to include c: 1, d: 2

    end
  end

  describe "#solr_doc_id" do
    before :each do
      subject.stub url: "https://archive.org/details/Ground_Truth"
    end

    it "should be the last segment of the URL" do
      expect(subject.solr_doc_id).to eq "ground_truth"
    end
  end

  describe "#harvest!", vcr: true do

    before :each do 
      subject.url = "https://archive.org/details/Ground_Truth"
    end

    it "should fetch the page and metadata from upstream" do
      subject.harvest!

      expect(subject.data[:raw_body]).to_not be_blank
      expect(subject.data[:metadata]).to_not be_blank
    end
  end

end