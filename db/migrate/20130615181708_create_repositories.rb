class CreateRepositories < ActiveRecord::Migration
  def change
    create_table   :repositories do |t|
      t.string     :name
      t.text       :description
      t.references :creator
      t.references :master_version

      t.timestamps
    end
  end
end
