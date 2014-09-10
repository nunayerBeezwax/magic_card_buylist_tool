class Agent
	require 'csv'

	def inventory_constructor
		file = IO.readlines('CardShark-Inventory-Export-20140627.txt')
		card_info_array = []
		file.each do |element| 
		 	element = element.gsub!(/\t/, "&&")
			 	if element.include?("&&&&")
			 		element.gsub!(/&&&&/, "&&False&&")
			 	else
			 		element.gsub!(/Foil/, "true")
			 	end
		 	card_info_array << element.gsub!(/&&/, "\t")[0..-3] 
		end

		card_info_array.each do |info_pack|
			info = info_pack.split("\t")
			Card.create(set: info[0],
						name: info[1],
						rarity: info[2],
						foil: info[3],
						condition: info[4],
						price: info[5],
						quantity: info[6])
		end
	end

		def strikezone_constructor
		card_info_array = []
		file = IO.readlines("Strikezone.txt")
		file.each {|l| card_info_array << l.squeeze!.split("\t")}
		card_info_array.each do |info|
			Buycard.create(set: info[0].strip, 
										name: info[1].strip,
										foil: info[2].include?("Foil"), 
										price: info[-1].to_f, 
										quantity: info[3].to_i)
		end
	end

	def mtgfanatic_constructor
		build_card = []
		card_info_array = []
		array = CSV.read('MtgFanatic-Buylist.csv')
		array.each {|i| i.shift}
		array.each {|i| i.pop}
		array.each do |item|
			build_card << item[0].split(" - ").first
			build_card << item[0].split(" - ").last.match(/^[^\(]*/).to_s.strip
			build_card << item.to_s.include?("foil" || "Foil")
			build_card << item.to_s.include?("Played" || "played")
			build_card << item[-2].gsub(/\$/, "").to_f
			build_card << item.last.to_i
			card_info_array << build_card
			build_card = []
		end
		card_info_array.each do |info|
			Buycard.create(set: info[0],
						name: info[1],
						foil: info[2],
						played: info[3],
						price: info[4],
						quantity: info[5])
		end
	end

	def get_all_matches
		Card.all.each do |card|
			sniff = Buycard.where("name = ? AND set = ? AND foil = ?", card.name, card.set, card.foil)
			if sniff.first
				if price_filter(card, sniff.first)
					Hit.create(card_id: card.id, buycard_id: sniff.first.id, price: sniff.first.price, quantity: compute_quantity(card, sniff.first))
				end
			end
		end
	end

	def write_matches(rar)
		File.open("#{rar}_sales.txt", 'w') do |file| 
			Hit.all(:order => "price").reverse.each do |hit|
				if hit.card.rarity == rar
					string = hit.card.name + " -- " + hit.card.condition + " -- " + hit.card.set + " -- " + (hit.card.foil ? "Foil" : "    ") + " --- " + hit.quantity.to_s + " --- " + hit.price.to_s
					file.write(string + "\n")
				end
			end
		end
	end

	def total_value(rar)
		total = 0
		Hit.all.each {|hit| hit.card.rarity == rar ? total += hit.price*hit.quantity : ''}
		total
	end

	def compute_quantity(inv_card, list_card)
		if list_card.quantity > inv_card.quantity
			inv_card.quantity
		else
			list_card.quantity
		end
	end

	def name_filter(inv_card)
		Buycard.find_by_name(inv_card.name)
	end

	def set_filter(inv_card)
		Buycard.find_by_set(inv_card.set)
	end

	def foil_filter(inv_card)
		Buycard.find_by_foil(inv_card.foil)
	end

	def price_filter(inv_card, buylist_card)
		if (buylist_card.price / inv_card.price) > 0.01
			true
		end
	end
end