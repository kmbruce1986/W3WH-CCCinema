require_relative('../db/sql_runner.rb')


class Screening

  attr_reader :id
  attr_accessor :film_id, :start_time

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @start_time = options['start_time']
  end

  def save
    sql = "INSERT INTO screenings (film_id, start_time) VALUES ($1, $2) RETURNING id"
    values = [@film_id, @start_time]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM screenings"
    screenings = SqlRunner.run(sql)
    result = screenings.map {|screening| Screening.new(screening)}
    return result
  end

  def update
    sql = "UPDATE screenings SET (film_id, start_time) = ($1, $2) WHERE id = $3"
    values = [@film_id, @start_time, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

end
