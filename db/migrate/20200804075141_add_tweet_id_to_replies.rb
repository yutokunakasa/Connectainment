class AddTweetIdToReplies < ActiveRecord::Migration[5.2]
  def change
    add_column :replies, :tweet_id, :string
  end
end
