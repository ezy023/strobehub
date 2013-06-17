class CreateTracks < ActiveRecord::Migration
  def change
    create_table    :tracks do |t|
      t.references  :version
      t.text        :url
      t.decimal     :delay,         :default => 0
      t.decimal     :offset,        :default => 0
      t.decimal     :duration,      :default => 0
      t.decimal     :volume,        :default => 1
      t.decimal     :track_length,  :default => 0

      t.timestamps
    end 
  end
end
