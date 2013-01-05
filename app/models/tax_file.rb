class TaxFile
	include Mongoid::Document
	attr_accessor :path, :liability, :year
end