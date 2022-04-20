class CreateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :logs do |t|
      t.string :userName
      t.string :type
      t.text :original
      t.text :new
      t.string :ip

      t.timestamps
    end
  end
end
