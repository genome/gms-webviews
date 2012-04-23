class CreateModelGroups < ActiveRecord::Migration
  def change
    create_table :model_groups do |t|

      t.timestamps
    end
  end
end
