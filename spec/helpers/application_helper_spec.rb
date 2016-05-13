require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do
  describe "#bootstrap_class_for" do
    context "expected flash message type" do
      it "returns the correct alert class for success type" do
        expect(helper.bootstrap_class_for(:success)).to eq('alert-success')
      end

      it "returns the correct alert class for error type" do
        expect(helper.bootstrap_class_for(:error)).to eq('alert-danger')
      end

      it "returns the correct alert class for alert type" do
        expect(helper.bootstrap_class_for(:alert)).to eq('alert-warning')
      end

      it "returns the correct alert class for notice type" do
        expect(helper.bootstrap_class_for(:notice)).to eq('alert-info')
      end
    end

    context "unexpected flash message type" do
      it "returns the type in string format" do
        expect(helper.bootstrap_class_for(:other)).to eq('other')
      end
    end
  end
end
