class CreateInformation < ActiveRecord::Migration[5.2]
  def change
    create_table :information do |t|


      t.string :text
      t.timestamps
    end
  end
end
