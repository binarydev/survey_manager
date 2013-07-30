class AddOrderToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :order_num, :integer
  end
end
