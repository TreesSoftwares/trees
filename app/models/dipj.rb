=begin
  * Name: DIPJ
  * Description: Classe de modelo que representa a Declaração de Informações Econômico-fiscais da Pessoa Jurídica
  * Author: @paulociecomp
  * Date: 27/12/2012
=end
class DIPJ < Liability
	
	def self.create_by_file(path, sistema, versao)
		f = File.open(path)
		lines = f.readlines
		dipj = DIPJ.new
		dipj.registrations = []

		layout = Layout.find_by(sistema: sistema, ano: versao)

		lines.each do |line|
				if lines[0] == line
					layout.header["campos"].each do |campo|
						dipj[campo["atributo"]] = line[(campo["inicio"].to_i - 1)..(campo["fim"].to_i - 1)]
					end
				end

				layout.registrations.each do |layout_da_ficha|
					unless layout_da_ficha["tipo_ficha"] != line[0..2]
						ficha = Ficha.new
						ficha.tipo = layout_da_ficha["tipo_ficha"]

						layout_da_ficha["campos"].each do |campo|
							ficha[campo["atributo"]] = line[(campo["inicio"].to_i - 1)..(campo["fim"].to_i - 1)]
						end

						dipj.registrations << ficha
					end
				end
		end
		
		dipj
	end
end