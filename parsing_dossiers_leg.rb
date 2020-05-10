require 'json'

Dir[File.join(__dir__, 'data/dossiers_leg/dossierParlementaire/*')][0..5].each do |filepath|
  serialized_leg = File.read(filepath)
  leg = JSON.parse(serialized_leg)
  # puts JSON.pretty_generate(leg['dossierParlementaire']['initiateur'])
  unless leg['dossierParlementaire']['initiateur'].nil?
    if leg['dossierParlementaire']['initiateur']['acteurs']['acteur'].class == Hash
      p leg['dossierParlementaire']['initiateur']['acteurs']['acteur']['acteurRef']
    elsif leg['dossierParlementaire']['initiateur']['acteurs']['acteur'].class == Array
      leg['dossierParlementaire']['initiateur']['acteurs']['acteur'].each { |acteur| p acteur['acteurRef'] }
    end
  end

#   p leg['dossierParlementaire']['uid']
#   p leg['dossierParlementaire']['initiateur']
#   p leg.include?("PA718784")
#   unless leg['dossierParlementaire']['initiateur'].nil?
# #   unless leg['dossierParlementaire']['initiateur']['acteurs'].nil?
# #     if leg['dossierParlementaire']['initiateur']['acteurs']['acteur'].class == String
#       p leg['dossierParlementaire']['initiateur']['acteurs']['acteur'][0]['acteurRef']
# #     end
# #   end
#   end
  puts "--------------------------------"
  puts "--------------------------------"
end
