require 'json'

# CHANGER LE FILEPATH TO RETURN AN HTML WITH A PRETTY JSON OF THE FILE INSIDE

filepath = File.join(__dir__, 'data/votes/VTANR5L15V1.json')
serialized_json = File.read(filepath)
json = JSON.parse(serialized_json)
puts JSON.pretty_generate(json)
json_string = JSON.pretty_generate(json).gsub("\n", '<br>').gsub(' ', '  ')

title = filepath.match(/\w+\.json/)[0].gsub('.', '_')

puts `touch pretty-json/#{title}.html`

votes_array = ['<!DOCTYPE html>',
               '<html lang="en">',
               '<head>',
               '<meta charset="UTF-8">',
               "<title>#{title}</title>",
               '<link rel="stylesheet" href="style.css">',
               '</head>',
               '<body>',
               '<div class="container">',
               json_string.to_s,
               '</div>',
               '</body>',
               '</html>']

File.write("pretty-json/#{title}.html", votes_array.join("\n"), mode: 'w')
