
require 'open-uri'
require 'nokogiri'

Skill.destroy_all

letters = ['a','b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
           'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
print "Creating skills"           
letters.each do |l|
  doc = Nokogiri::HTML(open("http://www.linkedin.com/skills/directory/#{l}"))
  length = doc.css('ul.directory li a').length
  
  (length-1).times do |t|
    d = l + t.to_s;
    doc1 = Nokogiri::HTML(open("http://www.linkedin.com/skills/directory/#{d}"))
    doc1.css('ul.directory li a').each do |link|
      Skill.create(:tag => link.content)
    end
  end
  print "."
end

puts ""
puts "Skills created."



