lines = File.readlines('./average_sizes.txt').map{|l| l.strip}

line = lines[17]


# Height



# Parse the expected plant height
#
# returns - inches, nil if not found
def parse_height(line)
  height_parsers = [
    { regexp: /[0-9]+(?= in. tall)/, unit: :in },
    { regexp: /[0-9]+ to [0-9]+ in. tall/, unit: :in },
    { regexp: /[0-9]+ to [0-9]+ feet tall/, unit: :ft },
    { regexp: /[0-9]+-[0-9]+ in. tall/, unit: :in },
    { regexp: /[0-9]+-[0-9]+\" H/, unit: :in },
    { regexp: /[0-9]+ to [0-9]+ ft[.]? tall/, unit: :ft },
    { regexp: /[0-9]+ ft. tall/, unit: :ft },
    { regexp: /[0-9]+ foot tall/, unit: :ft },
    { regexp: /[0-9]+ inches tall/, unit: :inches },
    { regexp: /reach [0-9]+ to [0-9]+ ft[.]?/, unit: :ft },
    { regexp: /reach [0-9]+ ft[.]?/, unit: :ft },
    { regexp: /[0-9]+ feet tall/, unit: :ft },
    { regexp: /[0-9]+ to [0-9]+ ft[.]? wide and tall/, unit: :ft },
    { regexp: /[0-9]+ to [0-9]+ in[.]? high/, unit: :in },
    { regexp: /[0-9]+ ft tall/, unit: :ft },
    { regexp: /[0-9]+ to [0-9]+ ft[.]? high/, unit: :ft },
    { regexp: /[0-9]+-[0-9]+ ft.tall/, unit: :ft },
    { regexp: /[0-9]+ to [0-9]+ ft. high/, unit: :ft },
    { regexp: /[0-9]+" tall/, unit: :in },
    { regexp: /[0-9]+-[0-9]+' H/, unit: :ft },
    { regexp: /[0-9]+"H/, unit: :in },
    { regexp: /[0-9]+ - [0-9]+ in[.]? high/, unit: :in },
    { regexp: /[0-9]+ ft[.]? high/, unit: :ft },
    { regexp: /[0-9]+ - [0-9]+" H/, unit: :in },
    { regexp: /[0-9]+" H/, unit: :in },
    { regexp: /[0-9]+ in. high/, unit: :in },
    { regexp: /[0-9]+ ft.tall/, unit: :ft },
  ]
  height_parsers.each do |parser|
    range = line.match(parser[:regexp]).to_s.scan(/[0-9]+/).map{|n| n.to_i}
    next unless range && range.length > 0

    value = nil
    value = range.reduce(:+) / range.length
    value = value * 12 if parser[:unit] == :ft
    return value
  end
  nil
end

# Parse the expected plant width
#
# returns - inches, nil if not found
def parse_width(line)
  height_parsers = [
    { regexp: /(?<=spreads to )[0-9]+ in[.]?/, unit: :in },
    { regexp: /[0-9]+ to [0-9]+ ft[.]? tall and wide/, unit: :ft },
    { regexp: /[0-9]+ to [0-9]+ in[.]? wide/, unit:  :in },
    { regexp: /[0-9]+-[0-9]+ in[.]? wide/, unit: :in },
    { regexp: /[0-9]+-[0-9]+\" W/, unit: :in },
    { regexp: /[0-9]+ to [0-9]+ ft[.]? wide/, unit: :ft },
    { regexp: /[0-9]+ ft[.]? wide/, unit: :ft },
    { regexp: /[0-9]+ inches wide/ , unit: :in },
    { regexp: /[0-9]+ in[.]? wide/ , unit: :in },
    { regexp: /[0-9]+ ft[.]? tall and wide/, unit: :ft },
    { regexp: /[0-9]+ in[.]? tall and wide/, unit: :in },
    { regexp: /[0-9]+ to [0-9]+ feet tall and wide/, unit: :ft },
    { regexp: /[0-9]+ to [0-9]+ feet wide/, unit: :ft },
    { regexp: /[0-9]+ to [0-9]+ in tall and wide/, unit: :in },
    { regexp: /[0-9]+ feet wide/, unit: :ft },
    { regexp: /[0-9]+ feet wide/, unit: :ft },
    { regexp: /[0-9]+' W/, unit: :ft },
    { regexp: /[0-9]+ inches tall and wide/, unit: :in },
    { regexp: /[0-9]+-[0-9]+"W/, unit: :in },
    { regexp: /[0-9]+ to [0-9]+ ft[.]? high, equal width/, unit: :ft },
    { regexp: /[0-9]+ to [0-9]+ ft[.]? high and wide/, unit: :ft },
    { regexp: /[0-9]+" wide/, unit: :in },
    { regexp: /[0-9]+ to [0-9]+ in[.]? high and wide/, unit: :in },
    { regexp: /18 in[.]? spread/, unit: :in },
    { regexp: /[0-9]+" W[.]?/, unit: :in },
    { regexp: /[0-9]+ in[.]? high and wide/, unit: :in }
  ]
  height_parsers.each do |parser|
    range = line.match(parser[:regexp]).to_s.scan(/[0-9]+/).map{|n| n.to_i}
    next unless range && range.length > 0

    value = nil
    value = range.reduce(:+) / range.length
    value = value * 12 if parser[:unit] == :ft
    return value
  end
  nil
end

lines.each do |line|
  puts parse_height(line)
end; 0

# Width
).to_s # Inches
).to_s.scan(/[0-9]+/) # Feet, average them
).to_s.scan(/[0-9]+/) # Feet, average them
).to_s.scan(/[0-9]+/) # Inches, average
).to_s.scan(/[0-9]+/) # Inches, average them
).to_s.scan(/[0-9]+/) # Inches, average them
).to_s.scan(/[0-9]+/) # Feet, average them
).to_s.scan(/[0-9]+/) # Feet, average them

