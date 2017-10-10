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

    def self.all()
      db = PG.connect({
        dbname: 'bounty_hunter',
        host: 'localhost'
        })
        sql = "SELECT * FROM bounties"
        values = []
        db.prepare("all", sql)
        bounties = db.exec_prepared("all", values)
        db.close()

        bounties_as_objects = bounties.map{ |bounty| Bounty.new(bounty)}
        return bounties_as_objects
      end

      def update()
        db = PG.connect({
          dbname: 'bounty_hunter',
          host: 'localhost'
          })
          sql = "UPDATE bounties
          SET (name, species, bounty_value, homeworld) =
          ($1, $2, $3, $4) WHERE id = $5"
          values = [@name, @species, @bounty_value, @homeworld, @id]
          db.prepare("update", sql)
          db.exec_prepared("update", values)
          db.close()
        end

        def delete()
          db = PG.connect({
            dbname: 'bounty_hunter',
            host: 'localhost'
            })
            sql = "DELETE FROM bounties
            WHERE id = $1"
            values = [@id]
            db.prepare("delete_one", sql)
            db.exec_prepared("delete_one", values)
            db.close()
          end

          def self.delete_all()
            db = PG.connect({
              dbname: 'bounty_hunter',
              host: 'localhost'
              })
              sql = "DELETE FROM bounties"
              values = []
              db.prepare("delete_all", sql)
              db.exec_prepared("delete_all", values)
              db.close()
            end

end
