class AddDeviseLockableToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :failed_attempts, :integer, default: 0, null: false
  	add_column :users, :unlock_token, :string
  	add_column :users, :locked_at, :datetime

  	add_index :users, :unlock_token, unique: true
  end


      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

    # add_index :users, :unlock_token,         unique: true

end
