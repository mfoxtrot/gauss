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

  def save(keys, properties)
    f = File.open('result.csv','w+')
    line = ''
    keys.each { |k| line = line + k + ';' }
    f.puts(line)
    properties.each do |p|
      unless p.nil?
        line = ''
        keys.each do |k|
          line = line + p[k].to_s
          line << ';'
        end
        f.puts(line)
      end
    end
    f.close
  end
end
