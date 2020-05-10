require 'json'

# filepath = File.join(__dir__, 'data/votes/VTANR5L15V1.json')

# serialized_vote = File.read(filepath)

# vote = JSON.parse(serialized_vote)
# puts vote['scrutin']['syntheseVote']['nombreVotants']

# puts vote['scrutin']['objet']['libelle']

deputes_array = ['<!DOCTYPE html>',
               '<html lang="en">',
               '<head>',
               '<meta charset="UTF-8">',
               '<title>deputes</title>',
               '<link rel="stylesheet" href="style.css">',
               '</head>',
               '<body>',
               '<div class="container">',
               "<div class='update-date'>last update : #{Time.now}</div><br>"]
total_dep = Dir[File.join(__dir__, 'data/AMO10_deputes_actifs_mandats_actifs_organes_XV/acteur/*')].size

Dir[File.join(__dir__, 'data/AMO10_deputes_actifs_mandats_actifs_organes_XV/acteur/*')].each_with_index do |filep, index|
  serialized_vote = File.read(filep)
  depute = JSON.parse(serialized_vote)
  p @depute_id = depute['acteur']['uid']['#text']
  p "#{index} / #{total_dep}"
  deputes_array << '<div class="depute">'
  deputes_array << "<strong>#{depute['acteur']['etatCivil']['ident']['prenom']} #{depute['acteur']['etatCivil']['ident']['nom']}</strong>" + '<br>'
  deputes_array << "né(e) le : #{depute['acteur']['etatCivil']['infoNaissance']['dateNais']} à #{depute['acteur']['etatCivil']['infoNaissance']['villeNais']}" + '<br>'
  deputes_array << "#{depute['acteur']['profession']['libelleCourant']}" + '<br>'
  deputes_array << "decla patrimoine : <a href='#{depute['acteur']['uri_hatvp']}'>#{depute['acteur']['uri_hatvp']}</a>" + '<br>'
  depute['acteur']['adresses']['adresse'][1..-1].each do |adresse|
    deputes_array << "adresse #{adresse['typeLibelle']} : #{adresse['valElec']}" + '<br>'
  end
  depute['acteur']['mandats']['mandat'].each do |mandat|
    deputes_array << "#{mandat['infosQualite']['libQualite']} de #{mandat['organes']['organeRef']} depuis le #{mandat['dateDebut']}" + '<br>'
  end
  deputes_array << '-------' + '<br>'
  deputes_array << "à l'initiave des dossiers parlementaires suivants :" + '<br>'
  Dir[File.join(__dir__, 'data/dossiers_leg/dossierParlementaire/*')].each do |filepath|
    serialized_leg = File.read(filepath)
    leg = JSON.parse(serialized_leg)
    # puts JSON.pretty_generate(leg['dossierParlementaire']['initiateur'])
    unless leg['dossierParlementaire']['initiateur'].nil?
      # p leg['dossierParlementaire']['initiateur'][0]
      if leg['dossierParlementaire']['initiateur'].key?("acteurs")
        if leg['dossierParlementaire']['initiateur']['acteurs']['acteur'].class == Hash
          if leg['dossierParlementaire']['initiateur']['acteurs']['acteur']['acteurRef'] == @depute_id
            p "match"
            deputes_array << "- #{leg['dossierParlementaire']['titreDossier']['titre']} (#{leg['dossierParlementaire']['procedureParlementaire']['libelle']})" + '<br>'
          end
        elsif leg['dossierParlementaire']['initiateur']['acteurs']['acteur'].class == Array
          leg['dossierParlementaire']['initiateur']['acteurs']['acteur'].each do |acteur|
            if acteur['acteurRef'] == @depute_id
              p "match"
              deputes_array << "- #{leg['dossierParlementaire']['titreDossier']['titre']} (#{leg['dossierParlementaire']['procedureParlementaire']['libelle']})" + '<br>'
            end
          end
        end
      end
    end
    # p leg['dossierParlementaire']['uid']
    # p leg['dossierParlementaire']['initiateur']
    # p leg.include?("PA718784")
    # unless leg['dossierParlementaire']['initiateur'].nil?
    #   unless leg['dossierParlementaire']['initiateur']['acteurs'].nil?
    #     if leg['dossierParlementaire']['initiateur']['acteurs']['acteur'].class == String
          # p leg['dossierParlementaire']['initiateur']['acteurs']['acteur'][0]['acteurRef']
          # if leg['dossierParlementaire']['initiateur']['acteurs']['acteur']['acteurRef'] == @deputeId
          #   deputes_array << '>>' + leg['dossierParlementaire']['titreDossier']['titre'] + '<br>'
          #   deputes_array << '>>' + leg['dossierParlementaire']['procedureParlementaire']['libelle'] + '<br>'
          #   deputes_array << '-------' + '<br>'
          # end
    #     end
    #   end
    # end
  end
  deputes_array << '-----------------' + '<br>'
  deputes_array << '</div>'
end

deputes_array << "<div class='update-date'>end of process : #{Time.now}</div><br>"
deputes_array << '</div>'
deputes_array << '</body>'
deputes_array << '</html>'

File.write('deputes.html', deputes_array.join("\n"), mode: 'w')
