#encoding: utf-8
class Leitor

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