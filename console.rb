require_relative("./models/pizza_order.rb")
require_relative("./models/customer.rb")
require("pry")

PizzaOrder.delete_all
Customer.delete_all

order1 = PizzaOrder.new({
  "first_name" => "Walter",
  "last_name"  => "White",
  "topping"    => "Pepperoni",
  "quantity"   => 1
  })

  order2 = PizzaOrder.new({
    "first_name" => "Jessie",
    "last_name"  => "Pinkman",
    "topping"    => "Vegetable",
    "quantity"   => 8
    })

    customer1 = Customer.new({
      "first_name" => "Kris",
      "last_name"  => "Mac"
      })

    customer2 = Customer.new({
      "first_name" => "Nathan",
      "last_name"  => "Atkinson"
      })

    customer1.save
    customer2.save

    order1.save()
    order2.save()

    orders = PizzaOrder.all

    customers = Customer.all

    p Customer.find(13)

    Customer.delete(13)


    binding.pry

    nil
