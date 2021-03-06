# == Schema Information
#
# Table name: labels
#
#  id         :integer          not null, primary key
#  project_id :integer
#  name       :string(255)
#  color      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Label do
  before do
    @label = FactoryGirl.build(:label)
  end

  subject { @label }

  describe "#text_color" do
    it "should be light when background is dark" do
      @label.color = "000000"
      @label.text_color.should == "light"
    end

    it "should be dark when background is light" do
      @label.color = "ffffff"
      @label.text_color.should == "dark"
    end
  end

  describe '#touch_all_bids' do
    it 'should update the timestamps of all the labels bids' do
      @label.stub(:bids).and_return(bids = [])
      bids.should_receive(:update_all)
      @label.send(:touch_all_bids)
    end
  end
end
