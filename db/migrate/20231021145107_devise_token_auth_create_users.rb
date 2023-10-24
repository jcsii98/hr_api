class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[7.0]
  def change
    
    create_table(:users) do |t|
      ## Required
      t.text :provider, :null => false, :default => "email"
      t.text :uid, :null => false, :default => ""

      ## Database authenticatable
      t.text :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.text   :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean  :allow_password_change, :default => false

      ## Rememberable
      t.datetime :remember_created_at

      ## Confirmable
      t.text   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.text   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.text   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## User Info
      t.text :kind
      t.text :first_name
      t.text :middle_name
      t.text :last_name
      t.text :profile_picture
      t.text :email
      t.integer :personal_rate
      t.date :birthday
      t.text :status, default: "pending"
      t.text :philhealth
      t.text :pagibig
      t.text :tin
      
      ## Tokens
      t.json :tokens

      t.timestamps
    end

    add_index :users, :email,                unique: true
    add_index :users, [:uid, :provider],     unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
