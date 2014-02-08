class CreateSpotlightImportInternetArchiveResources < ActiveRecord::Migration
  def change
    create_table :spotlight_import_internet_archive_resources do |t|
      t.string :url
      t.references :solr_document
      t.text :data

      t.datetime :indexed_at
      t.timestamps
    end
  end
end
