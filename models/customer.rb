require('pg')
#inks to posgress
require_relative ('../db/sql_runner.rb')

class Customer

attr_accessor(:first_name, :last_name)
attr_reader(:id)

#intialize
 def initialize(options)
   @id = options['id'].to_i()
   @first_name = options['first_name']
   @last_name = options['last_name']
 end

 def self.delete_all
   sql = "DELETE FROM customers;"
   SqlRunner.run(sql)
 end

 def self.all
   sql = "SELECT * FROM customers;"
   customer_hashes = SqlRunner.run(sql)

   customer_objects = customer_hashes.map do |customer|
     Customer.new(customer)
   end

   return customer_objects

 end

  def save
    sql = "
    INSERT INTO customers (
      first_name,
      last_name
    )
    VALUES ($1, $2)
    RETURNING id;
    "
    values = [
      @first_name,
      @last_name
      ]
    result = SqlRunner.run(sql, values)
    #result[0]["id"].to_i()
    result_hash = result[0]
    string_id = result_hash["id"]
    id = string_id.to_i()
    @id = id
  end

  def update
    sql = "
    UPDATE customers
    SET (
      first_name,
      last_name
    ) = ($1, $2)
    WHERE id = $3;
    "
    values = [
      @first_name,
      @last_name,
      @id
      ]

    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM customers
    WHERE $1 = id"

    values = [id]

    SqlRunner.run(sql, values)
  end

  def self.delete(id)
    sql = "DELETE FROM customers
    WHERE $1 = id"

    values = [id]

    SqlRunner.run(sql, values)
  end



  end
