class AddIndexToPopulations < ActiveRecord::Migration[5.2]
  def change
    # NOTE: We are doing a lot of queries by year. We may as well index it for
    # speed. We should also ensure that we only have one data point per year. So
    # we don't run around with multiple sources of "truth".
    add_index :populations, :year, unique: true
  end
end
