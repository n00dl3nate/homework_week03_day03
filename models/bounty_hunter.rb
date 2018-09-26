require('pg')

class BountyHunter

  attr_accessor(:name,:species,:bounty_value,:danger_level)

  def initialize(information)
    @id = information['id']
    @name = information['name']
    @species = information['species']
    @bounty_value = information['bounty_value'].to_i
    @danger_level = information['danger_level']

  end

  def self.delete_all()

    db = PG.connect({
      dbname: 'bounty_hunter',
      host: 'localhost'
      })

    sql = 'DELETE FROM bounty_hunter;'

    db.exec(sql)
    db.close

  end


  def save()

    db = PG.connect({
      dbname: 'bounty_hunter',
      host: 'localhost'
      })

    sql =
    "INSERT INTO bounty_hunter (
    name,
    species,
    bounty_value,
    danger_level
  )
    VALUES($1,$2,$3,$4)
    returning id;
    "

    db.prepare('save',sql)
    result = db.exec_prepared('save', [@name,@species,@bounty_value,@danger_level])

    db.close

    result_hash = result[0]

    string_id = result_hash['id']

    id = string_id.to_i()

    @id = id

  end

  def update()

    db = PG.connect({
      dbname: 'bounty_hunter',
      host: 'localhost'
      })

      sql =
      "
      UPDATE bounty_hunter
      SET (
        name,
        species,
        bounty_value,
        danger_level
      ) = ($1 , $2, $3, $4)
      WHERE id = $5; "

      values = [@name,@species,@bounty_value,@danger_level,@id]

      db.prepare('update',sql)

      db.exec_prepared('update',values)

      # db.exec(sql)
      db.close()

    end

    def self.find(id)

      db = PG.connect({
        dbname: 'bounty_hunter',
        host: 'localhost'
        })

      sql =
      " SELECT * FROM bounty_hunter WHERE id = $1;
      "

      values=[id]

      db.prepare('find',sql)
      result = db.exec_prepared('find', [id])

      db.close

      return result[0]

    end

    def self.find_delete(id)

      db = PG.connect({
        dbname: 'bounty_hunter',
        host: 'localhost'
        })

      sql =
      "DELETE FROM bounty_hunter WHERE id = $1;
      "

      values=[id]

      db.prepare('delete',sql)
      db.exec_prepared('delete', [id])

      db.close


    end
end
