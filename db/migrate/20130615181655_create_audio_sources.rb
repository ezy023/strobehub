class CreateAudioSources < ActiveRecord::Migration
  def change
    create_table :audio_sources do |t|
      t.string        :file

      t.timestamps
    end
  end
end
