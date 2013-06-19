class CreateRepoTags < ActiveRecord::Migration
  def change
  	create_table	:repo_tags do |t|
  		t.references	:repository
  		t.references 	:tag 

  		t.timestamps
  	end
  end
end
