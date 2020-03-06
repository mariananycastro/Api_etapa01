class JobOpportunity 
  attr_accessor :name, :headhunter_id, :description, :habilities, 
                :salary_range, :opportunity_level,
                :end_date_opportunity, :region

  @@all = []

  def initialize(name, headhunter_id, description, habilities, salary_range,
                opportunity_level, end_date_opportunity, region)
    @name = name
    @headhunter_id = headhunter_id
    @description = description
    @habilities = habilities
    @salary_range = salary_range
    @opportunity_level = opportunity_level
    @end_date_opportunity = end_date_opportunity
    @region = region

    @@all << self
  end

  def self.all
    @@all
  end

  def self.index(json)
    url = 'https://localhost:4000/' \
          'api/v1/job_opportunities'
    begin
      response = Faraday.get(url)
    rescue Faraday::ConnectionFailed
      puts 'erro'
      return []
    end
    json = catch_json(response)
    return [] if response.status == 500
    create_job_opportunity(json)
  end

  def self.create(json)
    job_opportunity = JSON.parse(json, symbolize_names: true)
    url = 'https://localhost:4000/' \
    'api/v1/job_opportunities'
    begin
      responde = Faraday.post(url, job_opportunity)
    rescue Faraday::ConnectionFailed
      puts 'erro'
      return []
    end
    json = catch_json(response)
    JobOpportunity.create_job_opportunity(job_opportunity)
  end

  private

  def self.catch_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def self.create_job_opportunity(json)
    json.map do |j|
      new(j[:name], j[:headhunter_id], j[:description], j[:habilities], j[:salary_range], 
          j[:opportunity_level], j[:end_date_opportunity], j[:region])
    end
  end
end
