class Query
  def initialize(dataset, &block)
    @dataset = dataset
    @query_objects = []
    instance_eval(&block) if block_given?
  end

  def use(query, *args)
    @query_objects <<
      case query
      when Class
        query.new(*args)
      when Proc
        query
      end
  end

  def invoke
    @query_objects.reduce(@dataset) {|dataset, query_obj| query_obj.call(dataset) }
  end
end
