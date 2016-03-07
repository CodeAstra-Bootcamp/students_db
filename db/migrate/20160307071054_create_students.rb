class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.references :section, index: true, foreign_key: true
      t.string :name
      t.string :fathers_name
      t.integer :gender
      t.string :email
      t.date :dob
      t.string :phone
      t.text :address

      t.timestamps null: false
    end
  end
end
