class CreateAccessTokens < ActiveRecord::Migration[4.2]
  def self.up
    create_table :access_tokens do |t|
      t.belongs_to :account, :client
      t.string :token,   null:false
      t.datetime :expires_at
      t.timestamps
    end
    add_index :access_tokens, :token, unique: true
  end

  def self.down
    drop_table :access_tokens
  end
end
