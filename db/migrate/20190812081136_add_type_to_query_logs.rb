class AddTypeToQueryLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :query_logs, :query_type, :integer
  end
end
