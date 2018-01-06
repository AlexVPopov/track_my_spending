class RemoveUnusedTags < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up { ActsAsTaggableOn::Tag.where(taggings_count: 0).destroy_all }
    end
  end
end
