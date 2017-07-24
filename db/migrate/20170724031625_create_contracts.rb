class CreateContracts < ActiveRecord::Migration[5.1]
  def change
    create_table :contracts do |t|
      t.string :title, null: false, comment: '合同标题'
      t.date :start_date, null: false, comment: '合同开始日期'
      t.date :end_date, null: false, comment: '合同截止日期'

      t.timestamps
    end
  end
end
