class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.references :section, index: true, foreign_key: true
      t.references :house, index: true, foreign_key: true
      t.integer :roll_number
      t.string :name
      t.string :fathers_name
      t.string :gender
      t.string :email
      t.date :dob
      t.string :phone
      t.text :address

      t.timestamps null: false
    end
  end
end
