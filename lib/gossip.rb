#Cette classe représente un gossip, elle est définie par son auteur et son contenu.
class Gossip

  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  #Sauvegarde l'instance dans le fichier csv
  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  #Renvoi la liste de tous les potins contenus dans le fichier CSV
  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  #renvoi le gossip correspondant à l'id passé en parametres
  def self.find(id)
    return Gossip.all[id]
  end

  def self.upgrade(author, content, id)
    gossip_array = self.all
		gossip_array[id.to_i].content = content
		gossip_array[id.to_i].author = author
		File.open("./db/gossip.csv", 'w') {|file| file.truncate(0) }
		gossip_array.each do |gossip|
			gossip.save
		end	
  end
end