class AddTextToReplies < ActiveRecord::Migration[5.2]
  def change
    add_column :replies, :text, :text
  end
end
