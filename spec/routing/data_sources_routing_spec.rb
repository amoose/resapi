require "spec_helper"

describe DataSourcesController do
  describe "routing" do

    it "routes to #index" do
      get("/data_sources").should route_to("data_sources#index")
    end

    it "routes to #new" do
      get("/data_sources/new").should route_to("data_sources#new")
    end

    it "routes to #show" do
      get("/data_sources/1").should route_to("data_sources#show", :id => "1")
    end

    it "routes to #edit" do
      get("/data_sources/1/edit").should route_to("data_sources#edit", :id => "1")
    end

    it "routes to #create" do
      post("/data_sources").should route_to("data_sources#create")
    end

    it "routes to #update" do
      put("/data_sources/1").should route_to("data_sources#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/data_sources/1").should route_to("data_sources#destroy", :id => "1")
    end

  end
end
