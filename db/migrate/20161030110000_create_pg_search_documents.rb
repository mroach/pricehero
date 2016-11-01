class CreatePgSearchDocuments < ActiveRecord::Migration
  def self.up
    say_with_time('Creating table for pg_search multisearch') do
      create_table :pg_search_documents do |t|
        t.text :content
        t.belongs_to :searchable, polymorphic: true, index: true
        t.timestamps null: false
      end

      execute <<-'SQL'
      CREATE INDEX index_pg_search_docments_on_content_trgm
        ON pg_search_documents
        USING gin (content gin_trgm_ops)
      SQL
      execute <<-'SQL'
      CREATE INDEX index_pg_search_docments_on_content_ts
        ON pg_search_documents
        USING gin (to_tsvector('english', content))
      SQL
    end
  end

  def self.down
    say_with_time('Dropping table for pg_search multisearch') do
      drop_table :pg_search_documents
      execute 'DROP INDEX index_pg_search_docments_on_content'
    end
  end
end
