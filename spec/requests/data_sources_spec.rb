require 'spec_helper'

describe "DataSources" do
  describe "GET /data_sources" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get data_sources_path
      response.status.should be(200)
    end
  end
end
