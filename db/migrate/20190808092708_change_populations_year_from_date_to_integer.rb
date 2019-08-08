class ChangePopulationsYearFromDateToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :populations, :year, :integer
  end
end
