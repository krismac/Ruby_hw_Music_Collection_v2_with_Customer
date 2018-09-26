require("pg")
require_relative("../db/sql_runner.rb")

class PizzaOrder

  attr_accessor(:first_name, :last_name, :topping, :quantity)
  attr_reader(:id, :customer_id)

  def initialize(options)
    @id          = options["id"].to_i()
    @first_name  = options["first_name"]
    @last_name   = options["last_name"]
    @topping     = options["topping"]
    @quantity    = options["quantity"].to_i()
    @customer_id = options["customer_id"].to_i()
  end

  def self.delete_all
    sql = 'DELETE FROM pizza_orders;'
    SqlRunner.run(sql)
  end

  def self.all()
      sql = "SELECT * FROM pizza_orders;"
      order_hashes = SqlRunner.run(sql)

      order_objects = order_hashes.map do |order_hash|
        PizzaOrder.new(order_hash)
      end

      return order_objects

  end

  def save()
    sql = "
      INSERT INTO pizza_orders (
        first_name,
        last_name,
        topping,
        quantity
      )
      VALUES ($1, $2, $3, $4)
      RETURNING id;
    "
    values = [
      @first_name,
      @last_name,
      @topping,
      @quantity
      ]

    result = SqlRunner.run(sql, values)
    #result[0]["id"].to_i()
    result_hash = result[0]
    string_id = result_hash["id"]
    id = string_id.to_i()
    @id = id
  end

  def update()
    sql = "
      UPDATE pizza_orders
      SET (
        first_name,
        last_name,
        topping,
        quantity
      ) = ($1, $2, $3, $4)
      WHERE id = $5;
    "
    values = [
      @first_name,
      @last_name,
      @topping,
      @quantity,
      @id
    ]
    SqlRunner.run(sql, values)
  end




end
