require 'json'

filepath = File.join(__dir__, 'data/votes/VTANR5L15V1.json')

serialized_vote = File.read(filepath)

vote = JSON.parse(serialized_vote)
puts vote['scrutin']['syntheseVote']['nombreVotants']

puts vote['scrutin']['objet']['libelle']

votes_array = ['<!DOCTYPE html>',
               '<html lang="en">',
               '<head>',
               '<meta charset="UTF-8">',
               '<title>votes</title>',
               '<link rel="stylesheet" href="style.css">',
               '</head>',
               '<body>',
               '<div class="container">']

Dir[File.join(__dir__, 'data/votes/*')].each do |filep|
  serialized_vote = File.read(filep)
  vote = JSON.parse(serialized_vote)
  votes_array << '<div class="vote">'
  votes_array << vote['scrutin']['objet']['libelle'] + "\n"
  votes_array << "nombre de votants : #{vote['scrutin']['syntheseVote']['nombreVotants']}" + "<br>"
  votes_array << "decompte : #{vote['scrutin']['syntheseVote']['decompte']}" + "<br>"
  votes_array << vote['scrutin']['syntheseVote']['annonce'] + "<br>"
  votes_array << '-----------------' + "<br>"
  votes_array << '</div>'
end

votes_array << '</div>'
votes_array << '</body>'
votes_array << '</html>'

File.write('votes_subjects.html', votes_array.join("\n"), mode: 'w')
