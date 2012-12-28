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
end