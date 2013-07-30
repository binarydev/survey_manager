class AddOrderToAnswerOptions < ActiveRecord::Migration
  def change
    add_column :answer_options, :order_num, :integer
  end
end
