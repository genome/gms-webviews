class CreateTaxons < ActiveRecord::Migration
  def change
    create_table :taxons do |t|

      t.timestamps
    end
  end
end
