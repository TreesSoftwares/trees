class Layout
	include Mongoid::Document

	field :header, type: Hash
	field :sistema
	field :versao
	field :registros, type: Array
end