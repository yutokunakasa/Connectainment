class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|

      t.string :title
      t.string :user_id
      t.string :movie_url_id
      t.string :introduction
      t.string :introducer_comment
      
      t.timestamps
    end
  end
end
