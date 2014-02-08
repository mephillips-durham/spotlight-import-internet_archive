require 'spec_helper'

describe Spotlight::Import::InternetArchive::Resource, integratin: true do
  it "should send the correct solr doc to solr", vcr: true do
    docs = []
    Blacklight.solr.should_receive(:add) { |doc|
      docs << doc
    }
    subject.url = "https://archive.org/details/Ground_Truth"
    subject.save

    doc = docs.first.with_indifferent_access
    expect(doc).to include id: "ground_truth"
  
    expect(doc).to include title_tesim: "The Ground Truth: The Human Cost of War"
  
    expect(doc).to include og_type_tesim: "video.movie"
  end
end