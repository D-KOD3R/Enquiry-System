class CreateEnquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :enquiries do |t|
      t.string :enquirer_email
      t.text :enquiry_content
      t.text :response_content
      t.integer :status
      t.integer :assigned_to_id

      t.timestamps
    end
    add_index :enquiries, :assigned_to_id

  end
end
