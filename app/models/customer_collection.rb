=begin
  * Name: CustomerCollection
  * Description: Model que representa uma collection de um cliente
  * que contem todas as informacoes de obrigacoes fiscais do referido cliente
  * Author: @paulociecomp
  * Date: 27/12/2012
=end
class CustomerCollection
	include Mongoid::Document

	embeds_many :liabilities
end