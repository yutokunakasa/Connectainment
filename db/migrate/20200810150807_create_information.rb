class CreateInformation < ActiveRecord::Migration[5.2]
  def change
    create_table :information do |t|

      t.text :text
      t.timestamps
    end
  end
end
