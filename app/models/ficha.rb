class Ficha
	include Mongoid::Document

	field :tipo
	field :campos, type: Array

	embedded_in :dipj
end