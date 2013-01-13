#encoding: utf-8
class Leitor

	private
	def self.pega_tipo_registro_da(frase)
		array_string_completa = frase.split(" ")
		tipo_registro = array_string_completa[array_string_completa.size - 1]
	end

	#lê o layout DIPJ 
	def self.loadLayout(file, contribuicao, versao)
		campos = []
		registro = Hash.new
		page = Nokogiri::HTML(open(file))

		tables = page.css('table')
		#layout = Layout.find_or_initialize_by(sistema: contribuicao, ano: versao)

		#layout[:tipo_contribuicao] = tables[0].css('tr:first td:first').text
		# layout[:ficha] = tables[0].css('tr:eq(3) td:first').text
		# layout[:registros] = []

		tables[1].css('tr').each do |link|
			unless link == tables[1].css('tr')[0] || link.css('td').text.empty?
		#		puts link.css('td').text
				ordem = link.css('td')[0].text
				campos << {
					ordem: ordem,
					nome: link.css('td')[1].text,
					atributo: self.pega_atributo(link, ordem),
					inicio: link.css('td')[2].text,
					fim: link.css('td')[3].text,
					tamanho: link.css('td')[4].text,
					formato: link.css('td')[5].text,
				}

			end
		end
		# require'pry'
		# binding.pry
		registro = {
			tipo: self.pega_tipo_registro_da(tables[0].css('tr:eq(3) td:first').text),
			campos: campos
		}
		
	end

	def self.pega_atributo(link, ordem)
		atributo = link.css('td')[1].text.gsub(/[0-9]|\.| |\(|\)|\-|\,/, ' ' => '_', '- ' => '').removeaccents.downcase.gsub(/^\_|\__/, '__' => '_')
		
		if atributo == 'reservado'
			return atributo + ordem
		end

		atributo
	end

	def self.loadHeader(file)
		campos = []
		header = Hash.new
		page = Nokogiri::HTML(open(file))

		tables = page.css('table')

		tables[1].css('tr').each do |link|
			unless link == tables[1].css('tr')[0] || link.css('td').text.empty?
		#		puts link.css('td').text
				ordem = link.css('td')[0].text
				campos << {
					ordem: ordem,
					nome: link.css('td')[1].text,
					atributo: self.pega_atributo(link, ordem),
					inicio: link.css('td')[2].text,
					fim: link.css('td')[3].text,
					tamanho: link.css('td')[4].text,
					formato: link.css('td')[5].text,
				}

			end
		end

		header = {
			campos: campos
		}
	end

	#le o diretorio que contem os layouts
	def self.readLayouts(path, contribuicao, versao)
		layout = Layout.find_or_initialize_by(sistema: contribuicao, ano: versao)

		if layout.registros.nil?
			layout.registros = []
		end
		
		Dir.foreach(path) do |arquivo|
			unless arquivo.gsub(/\.+/, '.' => '').blank?
				if arquivo == "header.html"
					layout.header = self.loadHeader(path + arquivo)
				else
					layout.registros << self.loadLayout(path + arquivo, contribuicao, versao)
				end
			end
		end

		layout.save
	end

end