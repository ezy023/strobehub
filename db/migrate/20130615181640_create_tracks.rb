class CreateTracks < ActiveRecord::Migration
  def change
    create_table    :tracks do |t|
      t.references  :version
      t.string      :url
      t.decimal     :delay
      t.decimal     :offset
      t.decimal     :duration
      t.decimal     :volumne
      t.decimal     :track_length

      t.timestamps
    end 
  end
end
