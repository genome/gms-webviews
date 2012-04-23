class CreateProcessingProfileParams < ActiveRecord::Migration
  def change
    create_table :processing_profile_params do |t|

      t.timestamps
    end
  end
end
