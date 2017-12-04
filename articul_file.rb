class ArticulFile
  attr_reader :articuls
  attr_reader :filename
  def initialize(filename)
    @articuls = []
    @filename = filename
  end

  def read
    f = File.open(filename,'r')
    f.each_line do |line|
      @articuls << line
    end
    f.close
  end

  def show
    articuls.each { |a| puts a }
  end
end

f = ArticulFile.new('articul.txt')
f.read
f.show
