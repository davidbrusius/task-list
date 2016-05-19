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

  describe "#active_link_to" do
    context "current_page? evaluates to true" do
      it "returns a link with active class" do
        allow(self).to receive(:current_page?).and_return(true)
        generated_link = active_link_to('Some Link', '/some_link')
        expect(generated_link).to match(/active/)
      end
    end

    context "current_page? evaluates to false" do
      it "returns a link without active class" do
        allow(self).to receive(:current_page?).and_return(false)
        generated_link = active_link_to('Some Link', '/some_link')
        expect(generated_link).not_to match(/active/)
      end
    end
  end
end
