#encoding: utf-8
class Leitor

	#lê o layout DIPJ 
	def self.loadLayout(file)
		page = Nokogiri::HTML(open(file))

		tables = page.css('table')
		layout = Layout.new
		#p tables[0].css('tr:eq(3) td:first').text
		#
		layout[:tipo_contribuicao] = tables[0].css('tr:first td:first').text
		layout[:ficha] = tables[0].css('tr:eq(3) td:first').text
		layout[:campos] = []

		tables[1].css('tr').each do |link|
			unless link == tables[1].css('tr')[0] || link.css('td').text.empty?
				p '##'
				puts link.css('td').text

				layout[:campos] << {
					ordem: link.css('td')[0].text,
					nome: link.css('td')[1].text,
					inicio: link.css('td')[2].text,
					fim: link.css('td')[3].text,
					tamanho: link.css('td')[4].text,
					formato: link.css('td')[5].text,
				} 

			end
		end

		layout.save
	end

end