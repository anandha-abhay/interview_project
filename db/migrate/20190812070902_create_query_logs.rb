class CreateQueryLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :query_logs do |t|
      t.integer :year, null: false
      t.bigint :population, null: false

      t.timestamps
    end

    add_index :query_logs, :year, unique: false
  end
end
