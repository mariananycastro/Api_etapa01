require 'rails_helper'
context 'receives data from api' do
  scenario 'index', :vcr do
      #bloco utilizo se nao tiver o :vcr
    # VCR.use_cassette("index_api") do
      # json = File.read(Rails.root.join('spec/support/index.json'))
      # response = double('response', status: 200, body: json)
      # url = 'http://localhost:4000/api/v1/job_opportunities'

      # allow(Faraday).to receive(:get).with(url).and_return(response)

      job_opportunities = JobOpportunity.index
      
      expect(JobOpportunity.all.count).to eq(2)
    # end
  end

  scenario 'create', :vcr do
    json = File.read(Rails.root.join('spec/support/create.json'))
    #json.name = 'Programador Ruby'
    # url = 'https://localhost:4000/api/v1/job_opportunities'
    # response = double('response', status: 201)
    
    response = JobOpportunity.create(json)
    body = JSON.parse(response.body, symbolize_names: true)
    # allow(Faraday).to receive(:post).with(url, job_opportunity).and_return(response)
    
    expect(response.status).to eq(201)
    JSON.parse(json).each do |key, value|
      expect(body[key.to_sym].to_s).to eq value
    end

  end

end
