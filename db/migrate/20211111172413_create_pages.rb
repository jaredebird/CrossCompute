class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages do |t|
      t.text :title
      t.text :layout
      t.integer :order
      t.boolean :dental
      t.boolean :medical
      t.boolean :vision

      t.timestamps
    end
  end
end
