=begin
  * Name: Liability
  * Description: Classe de modelo que identifica uma obrigacao fiscal
  * Author: @paulociecomp
  * Date: 27/12/2012
=end
class Liability
	include Mongoid::Document

	embeds_many :registrations
	embedded_in :customer_collection

	field :sistema, type: String
	field :versao_pgd, type: String

	attr_accessor :file

	def create_by_file(path)
		f = File.open(path)
		lines = f.readlines
		#liability.registrations = []

		layout = Layout.find_by(sistema: sistema, ano: versao_pgd)

		lines.each do |line|
				if lines[0] == line
					layout.header["campos"].each do |campo|
						self[campo["atributo"]] = line[(campo["inicio"].to_i - 1)..(campo["fim"].to_i - 1)]
					end
				end

				layout.registros.each do |layout_da_ficha|
					unless layout_da_ficha["tipo"] != line[0..3].strip
						ficha = Registration.new
						
						ficha.tipo = layout_da_ficha["tipo"]

						layout_da_ficha["campos"].each do |campo|
							ficha[campo["atributo"]] = line[(campo["inicio"].to_i - 1)..(campo["fim"].to_i - 1)]
						end

						self.registrations << ficha
					end
				end
		end

		customer = CustomerCollection.with(collection: self.registrations.first.cnpj_do_contribuinte).find_by(cnpj: self.registrations.first.cnpj_do_contribuinte)

		if customer.nil?
			customer = CustomerCollection.with(collection: self.registrations.first.cnpj_do_contribuinte).new(cnpj: self.registrations.first.cnpj_do_contribuinte)
		end

		liability = customer.liabilities.find_by(sistema: sistema, versao_pgd: versao_pgd)

		if liability.nil?
			customer.liabilities << self
		else
			liability = self
			customer.liabilities << liability
		end

		customer
	end
end