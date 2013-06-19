class CreateVersions < ActiveRecord::Migration
  def change
    create_table      :versions do |t|
      t.references    :user
      t.references    :repository
      t.references		:parent_version

      t.timestamps
    end
  end
end
