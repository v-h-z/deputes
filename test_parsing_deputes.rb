require 'json'

# filepath = File.join(__dir__, 'data/votes/VTANR5L15V1.json')

# serialized_vote = File.read(filepath)

# vote = JSON.parse(serialized_vote)
# puts vote['scrutin']['syntheseVote']['nombreVotants']

# puts vote['scrutin']['objet']['libelle']

votes_array = ['<!DOCTYPE html>',
               '<html lang="en">',
               '<head>',
               '<meta charset="UTF-8">',
               '<title>votes</title>',
               '<link rel="stylesheet" href="style.css">',
               '</head>',
               '<body>',
               '<div class="container">']

Dir[File.join(__dir__, 'data/AMO10_deputes_actifs_mandats_actifs_organes_XV/acteur/*')].each do |filep|
  serialized_vote = File.read(filep)
  depute = JSON.parse(serialized_vote)
  votes_array << '<div class="depute">'
  votes_array << "<strong>#{depute['acteur']['etatCivil']['ident']['prenom']} #{depute['acteur']['etatCivil']['ident']['nom']}</strong>" + '<br>'
  votes_array << "né(e) le : #{depute['acteur']['etatCivil']['infoNaissance']['dateNais']} à #{depute['acteur']['etatCivil']['infoNaissance']['villeNais']}" + '<br>'
  votes_array << "#{depute['acteur']['profession']['libelleCourant']}" + '<br>'
  votes_array << "decla patrimoine : <a href='#{depute['acteur']['uri_hatvp']}'>#{depute['acteur']['uri_hatvp']}</a>" + '<br>'
  depute['acteur']['adresses']['adresse'][1..-1].each do |adresse|
    votes_array << "adresse #{adresse['typeLibelle']} : #{adresse['valElec']}" + '<br>'
  end
  depute['acteur']['mandats']['mandat'].each do |mandat|
    votes_array << "#{mandat['infosQualite']['libQualite']} de #{mandat['organes']['organeRef']} depuis le #{mandat['dateDebut']}" + '<br>'
  end
  votes_array << '-----------------' + '<br>'
  votes_array << '</div>'
end

votes_array << '</div>'
votes_array << '</body>'
votes_array << '</html>'

File.write('index.html', votes_array.join("\n"), mode: 'w')
