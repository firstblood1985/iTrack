class Baseline < ActiveRecord::Base

	type_regx = /(^rep$)|(^time$)/
	validates :baseline_type, presence: true, format: {with:type_regx}
end
