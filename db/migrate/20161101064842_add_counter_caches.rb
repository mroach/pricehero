class AddCounterCaches < ActiveRecord::Migration[5.0]
  CACHES = { brands: 'products', categories: 'products', products: 'variants' }

  def up
    CACHES.each do |parent, child|
      cache_column = "#{child}_count"
      add_column parent, cache_column, :integer, null: false, default: 0
      execute <<-SQL.strip_heredoc
        UPDATE #{parent} SET #{cache_column} = (
          SELECT COUNT(*) FROM #{child} WHERE #{parent.to_s.singularize}_id = #{parent}.id)
      SQL
      add_index parent, cache_column
    end
  end

  def down
    CACHES.each do |parent, child|
      remove_column parent, "#{child}_count"
    end
  end
end
