require 'spec_helper'

describe Target do
 
	before { @target = Target.new(host: "localhost", path: "/tmp") }
	
	subject { @target }
	
	it { should respond_to(:host) }
	it { should respond_to(:path) } 
 
	it { should be_valid }

	describe "when host is not present" do
		before { @target.host = " " }
		it { should_not be_valid }
	end
	
	describe "when path is not present" do
		before { @target.path = " " }
		it { should_not be_valid }
	end
	
end