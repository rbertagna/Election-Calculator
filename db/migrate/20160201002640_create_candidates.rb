class CreateCandidates < ActiveRecord::Migration
  def up
    create_table :candidates do |t|
      t.string :name
      t.string :party
      t.string :state
      t.string :img_url
      t.integer :rating
    end
  end

  def down
    drop_table :musicians
  end
end
