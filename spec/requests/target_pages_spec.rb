require 'spec_helper'

describe "TargetPages" do

	subject { page }

	describe "target page" do
		before { visit targets_path }

		it { should have_content('Listing targets')}
		it { should have_title(full_title('Targets'))}

	end

end
