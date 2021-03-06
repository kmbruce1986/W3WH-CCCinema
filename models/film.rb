require_relative('../db/sql_runner.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    result = films.map {|film| Film.new(film)}
    return result
  end

  def update
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def customers
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE tickets.film_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map {|customer| Customer.new(customer)}
  end

  def number_of_customers
    sql = "SELECT tickets.film_id FROM tickets WHERE tickets.film_id = $1"
    values = [@id]
    number_of_customers = SqlRunner.run(sql, values)
    return number_of_customers.count
  end

  def most_tickets_sold
    sql = "SELECT screenings.start_time FROM screenings INNER JOIN tickets ON screenings.id = tickets.screening_id WHERE tickets.film_id = $1"
    values = [@id]
    tickets_sold = SqlRunner.run(sql, values)
    times = tickets_sold.map {|screening| screening['start_time']}
    return times.max_by {|time| times.count(time)}
  end

end
