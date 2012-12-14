class DIPJ
	include Mongoid::Document

	field :tipo
	field :reservado0
	field :mes
	field :periodo
	field :cnpj_contribuinte
	field :ano_calendario
	field :declaracao_retificadora
	field :cnpj_estabelecimento
	field :existe_movimento_periodo
	field :saldo_credor_periodo_anterior
	field :debito
	field :credito
	field :saldo_apurado
	field :credor_devedor
	field :reservado1
	field :delimitador_registro
	
end