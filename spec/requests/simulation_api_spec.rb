require 'rails_helper'
  context 'receves data from api' do
    scenario 'index' do
      json = File.read(Rails.root.join('spec/support/index.json'))
      response = double('response', status: 200, body: json)
      url = 'https://localhost:4000/api/v1/job_opportunities'

      allow(Faraday).to receive(:get).with(url).and_return(response)

      job_opportunities = JobOpportunity.index(json)
      
      expect(JobOpportunity.all.count).to eq(3)
    end

    scenario 'create' do
      json = File.read(Rails.root.join('spec/support/create.json'))
      #json.name = 'Programador Ruby'
      url = 'https://localhost:4000/api/v1/job_opportunities'
      job_opportunity = JSON.parse(json, symbolize_names: true)
      response = double('response', status: 201)
      
      JobOpportunity.create(json)
      
      allow(Faraday).to receive(:post).with(url, job_opportunity).and_return(response)
      byebug
      
      expect(response.status).to eq(201)
      expect(JobOpportunity.all.count).to eq(1)
    end

  end