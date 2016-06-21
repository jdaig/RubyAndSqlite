require 'sqlite3'
require 'date'
require 'time'


class Chef
  def initialize(name,last_name,birthday,email,phone,created_at = Date.new,updated_at = Date.new)
    @name = name
    @last_name = last_name
    @birthday = birthday
    @email = email
    @phone = phone 
    time = Time.new
    @created_at = time.strftime("%Y-%m-%d %H:%M:%S")
    @updated_at = time.strftime("%Y-%m-%d %H:%M:%S")

  end

  def self.create_table
    Chef.db.execute(
      <<-SQL
        CREATE TABLE chefs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name VARCHAR(64) NOT NULL,
          last_name VARCHAR(64) NOT NULL,
          birthday DATE NOT NULL,
          email VARCHAR(64) UNIQUE NOT NULL,
          phone VARCHAR(64) NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );
      SQL
    )
  end


  def save

    Chef.db.execute(
      <<-SQL
        INSERT INTO chefs
          (first_name, last_name, birthday, email, phone, created_at, updated_at)
        VALUES
          ("#{@name}", "#{@last_name}", "#{@birthday}", "#{@email}", "#{@phone}", "#{@created_at}", "#{@updated_at}");
      SQL
    )
  end

  def all
    Chef.db.execute(
      <<-SQL
        SELECT * FROM chefs;
      SQL
    )
  end

  def where(field, search_field)

    Chef.db.execute("SELECT * FROM chefs WHERE #{field} = ?","#{search_field}")

  end

  def delete(field, search_field)

    Chef.db.execute("DELETE FROM chefs WHERE #{field} = ?","#{search_field}")

  end


  def self.seed
    Chef.db.execute(
      <<-SQL
        INSERT INTO chefs
          (first_name, last_name, birthday, email, phone, created_at, updated_at)
        VALUES
          ('Ferran', 'Adriá', '1985-02-09', 'ferran.adria@elbulli.com', '42381093238', DATETIME('now'), DATETIME('now')),
          ('Aldo', 'Gonzalez', '1994-04-09', 'aldomono@gmail.com', '5564564323', DATETIME('now'), DATETIME('now')),
          ('Ruben', 'Gonzalez', '1989-03-02', 'rigonzalezvazquez@gmail.com', '5539962898', DATETIME('now'), DATETIME('now')),
          ('Victor', 'Zamora', '1989-07-09', 'vichito69@gmail.com', '5587450945', DATETIME('now'), DATETIME('now')),
          ('Brenda', 'Luna', '1992-04-12', 'brenluna@gmail.com', '5543174532', DATETIME('now'), DATETIME('now'));
      SQL
    )
  end


  private

  def self.db
    @@db ||= SQLite3::Database.new("chefs.db")
  end

end


chef_1 = Chef.new('Lalo','Landa','1999-05-08','lalo@gmai.com','5543231234')

#chef_1.save
#puts chef_1.all
# puts chef_1.where('id', '7')
# puts chef_1.delete('id', '7')
# puts chef_1.where('id', '7')
puts chef_1.all

