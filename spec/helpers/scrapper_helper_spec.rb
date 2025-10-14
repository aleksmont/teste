require 'rails_helper'

RSpec.describe ScrapperHelper, type: :helper do
  describe ScrapperHelper do

    context "check_url" do
      it "success" do
        aleksander_github_url = 'https://github.com/aleksmont'

        expect(helper.check_url(aleksander_github_url)).to be true
      end

      it "error" do
        google_url = 'https://google.com'

        expect(helper.check_url(google_url)).to be false
      end
    end

    context "success" do
      it "Find and return the correct value" do
        aleksander_github_url = 'https://github.com/aleksmont'

        expect(helper.search(aleksander_github_url)[:success]).to be true
        expect(helper.search(aleksander_github_url)[:data][:github_username]).to eq("aleksmont")
      end
    end

    context "error" do
      it "Not found results with entered url" do
        not_found_github_url = 'https://github.com/fodsjfoidsjfodisjfiodsjfdosi'

        expect(helper.search(not_found_github_url)[:success]).to be false
      end
    end

  end
end
