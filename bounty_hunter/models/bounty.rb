require('pg')

class Bounty
  attr_accessor :name, :species, :bounty_value, :homeworld
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @species = options['species']
    @bounty_value = options['bounty_value'].to_i()
    @homeworld = options['homeworld']
  end

  def create()
    db = PG.connect({
      dbname: 'bounty_hunter',
      host: 'localhost'
      })
      sql = "
      INSERT INTO bounties (name, species, bounty_value, homeworld)
      VALUES ($1, $2, $3, $4) RETURNING *
      "
      values = [@name, @species, @bounty_value, @homeworld]
      db.prepare("create", sql)
      @id = db.exec_prepared("create", values)[0]['id'].to_i()
      db.close()
    end

end
