class SolrSearch

  def self.search(opts)
    opts = {
      "page" => 1,
      "page_size" => 20,
      "facet" => true,
      "hl" => true,
      "qs" => 1,
      "facet.field" => "{!ex=tt}type"
    }.merge(opts) { |key,old,new| new ? new : old }

    opts["fq"] = "{!tag=tt}type:\"#{opts["fq"]}\"" if opts["fq"]

    cache_key = "search-#{opts.to_s}"

    if Rails.cache.exist?(cache_key)
      SolrSearch.new Rails.cache.fetch(cache_key)
    else
      solr = RSolr.connect url: SOLR_CONNECTION_STRING
      results = solr.paginate opts.delete("page"), opts.delete("page_size"), "select", params: opts

      unless results["response"]["numFound"] == 0
        Rails.cache.write(cache_key, results, expires_in: 30.minutes)
      end
      SolrSearch.new results
    end
  end

  def facets
    return @facets if @facets

    @facets = []
    @results["facet_counts"]["facet_fields"]["type"].each_slice(2){|x,y| @facets << [x,y] if y > 0}
    @facets
  end

  def docs
    @results["response"]["docs"]
  end

  private

    def initialize(results)
      @results = results
    end
end

