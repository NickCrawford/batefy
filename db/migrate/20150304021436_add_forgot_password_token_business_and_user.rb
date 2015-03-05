class AddForgotPasswordTokenBusinessAndUser < ActiveRecord::Migration
  def change
  	add_column :businesses, :forgot_password_token, :string
  	add_column :users, :forgot_password_token, :string
  end
end
