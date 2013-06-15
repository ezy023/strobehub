class CreateAudioSources < ActiveRecord::Migration
  def change
    create_table :audio_sources do |t|
      t.string   :type
      t.string   :filename
      t.string   :title
      t.text     :data

      t.timestamps
    end
  end
end
