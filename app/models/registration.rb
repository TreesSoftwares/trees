class Registration
	include Mongoid::Document

	field :tipo
	field :campos, type: Array

	embedded_in :liability
end