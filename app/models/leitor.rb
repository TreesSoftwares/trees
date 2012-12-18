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
		# require 'pry'
		# binding.pry
	end

	def self.load(file)
		f = File.open(file)
		lines = f.readlines

		lines.each do |line| 
			if line[0..2] == 'R20'
				#require 'pry'
				dipj = DIPJ.new

				dipj.tipo = line[0..2]
				dipj.reservado0 = line[3..3]
				dipj.mes = line[4..5]
				dipj.periodo = line[6..7]
				dipj.cnpj_contribuinte = line[8..21]
				dipj.ano_calendario = line[22..22]
				dipj.declaracao_retificadora = line[23..23]
				dipj.cnpj_estabelecimento = line[24..29]
				dipj.existe_movimento_periodo = line[30..30]
				dipj.saldo_credor_periodo_anterior = line[31..44]
				dipj.debito = line[45..58]
				dipj.credito = line[59..72]
				dipj.saldo_apurado = line[73..86]
				dipj.credor_devedor = line[87..87]
				dipj.reservado1 = line[88..97]
				dipj.delimitador_registro = line[98..99]
				
				dipj.save
				 #binding.pry
			end

			# p '##############'
			# require 'pry'
			# p line
			# binding.pry
		end
	end

end