require_relative 'articul_file'
require_relative 'gauss_parser'

a = ArticulFile.new('articul.txt')
a.read

parser = GaussParser.new(a.articuls)
parser.search_links
#puts parser.parsing_results
puts parser.keys

a.save(parser.keys, parser.parsing_results)
