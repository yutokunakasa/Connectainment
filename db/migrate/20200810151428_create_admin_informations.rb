class CreateAdminInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_informations do |t|

      t.text :text

      t.timestamps
    end
  end
end
