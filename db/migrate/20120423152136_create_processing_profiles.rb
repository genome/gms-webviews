class CreateProcessingProfiles < ActiveRecord::Migration
  def change
    create_table :processing_profiles do |t|

      t.timestamps
    end
  end
end
