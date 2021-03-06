require_relative('models/screening')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

require('pry-byebug')

Ticket.delete_all
Screening.delete_all
Customer.delete_all
Film.delete_all


film1 = Film.new({
  'title' => "Antman and the Wasp",
  'price' => 5
  })

film1.save

film2 = Film.new({
  'title' => "Mission Impossible Fallout",
  'price' => 10
  })

film2.save

customer1 = Customer.new({
  'name' => "John",
  'funds' => 50
  })

customer1.save

customer2 = Customer.new({
  'name' => "Kirsty",
  'funds' => 20
  })

customer2.save

screening1 = Screening.new({
  'film_id' => film1.id,
  'start_time' => "19:00"
  })

screening1.save

screening2 = Screening.new({
  'film_id' => film2.id,
  'start_time' => "20:00"
  })

screening2.save

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id,
  'screening_id' => screening1.id
  })

ticket1.save

ticket2 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film2.id,
  'screening_id' => screening2.id
  })

ticket2.save

ticket3 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film1.id,
  'screening_id' => screening1.id
  })

ticket3.save

binding.pry
nil
