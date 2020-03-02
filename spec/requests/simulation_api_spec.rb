require 'rails_helper'
  context 'receves data from api' do
    scenario 'index' do
      json = File.read(Rails.root.join('spec/support/job_opportunity.json'))
      response = double('response', status: 200, body: json)
      url = 'https://localhost:4000/api/v1/job_opportunities/'

      allow(Faraday).to receive(:get).with(url).and_return(response)

      job_opportunities = JobOpportunity.index(json)
      
      expect(JobOpportunity.all.count).to eq(3)
    end
  end