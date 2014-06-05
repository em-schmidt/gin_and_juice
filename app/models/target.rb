class Target < ActiveRecord::Base
	validates :host, presence: true
	validates :path, presence: true
end
