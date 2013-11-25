require 'spec_helper'

describe "BaseController" do
  before do
    get "/"
  end

  it "returns welcome message" do
    expect(last_response.body).to include('Welcome to nilgiri')
  end
end
