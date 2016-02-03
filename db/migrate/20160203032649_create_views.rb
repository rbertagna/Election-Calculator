class CreateViews < ActiveRecord::Migration

  def up
    create_table :views do |t|
      t.integer :views
    end
  end

  def down
    drop_table :views
  end

end
