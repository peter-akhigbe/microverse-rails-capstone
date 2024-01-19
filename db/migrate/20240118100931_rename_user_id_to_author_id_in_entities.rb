class RenameUserIdToAuthorIdInEntities < ActiveRecord::Migration[7.1]
  def change
    rename_column :entities, :user_id, :author_id
  end
end
